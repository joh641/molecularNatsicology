require "#{Rails.root}/lib/rules/rule"

class AndRule < Rule
  def check(plan, entries, flags=[], fulfilling_set)
    Rule.parse_entries(entries).each do |rule, args|
      return false unless rule.check plan, args, flags, fulfilling_set
    end
    true
  end
end
Rule.add(AndRule.new :and)

class OrRule < Rule
  def check(plan, entries, flags=[], fulfilling_set)
    Rule.parse_entries(entries).each do |rule, args|
      return true if rule.check plan, args, flags, fulfilling_set
    end
    false
  end
end
Rule.add(OrRule.new :or)

class NotRule < Rule
  def check(plan, entries, flags=[], fulfilling_set)
    Rule.parse_entries(entries).each do |rule, args|
      return false if rule.check plan, args, flags << "NOT", fulfilling_set
    end
    true
  end
end
Rule.add(NotRule.new :not)

class UnitsRule < Rule
  def check(plan, entry, flags=[], fulfilling_set)
    total = 0
    numunits = entry[0]['numunits']
    rule = entry[1]
    rule, args = Rule.parse_entry rule
    plan.courses.each { |course| 
      if rule.check course, args, flags, fulfilling_set
        total += course.units
        course.rule_list.add @@current_rule
        course.rule_list.add @@top_level_rule
        course.save unless flags.include? "NOT"
        fulfilling_set.add course unless flags.include? "NOT"
      end
    }
    total >= numunits
  end
end
Rule.add(UnitsRule.new :units)

class CoursesRule < Rule
  def check(plan, entry, flags=[], fulfilling_set)
    total = 0
    numcourses = entry[0]['numcourses']
    rule = entry[1]
    rule, args = Rule.parse_entry rule
    plan.courses.each { |course| 
      if rule.check course, args, flags, fulfilling_set
        total += 1
        course.rule_list.add @@current_rule
        course.rule_list.add @@top_level_rule
        course.save unless flags.include? "NOT"
        fulfilling_set.add course unless flags.include? "NOT"
      end
    }
    total >= numcourses
  end
end
Rule.add(CoursesRule.new :courses)

class SeriesRule < Rule
  def check(plan, entry, flags=[], fulfilling_set)
    rule = entry[0]
    rule, args = Rule.parse_entry rule
    plan.courses.each do |course| 
      courses = Plan.new
      department = course.name.match(/^([^.]+)/)[0]
      plan.courses.each { |course| courses.add course if course.name.match(/^([^.]+)/)[0] == department }
      return true if rule.check courses, args, flags, fulfilling_set
    end
    false
  end
end
Rule.add(SeriesRule.new :series)

# This is ANDcourse. We do not need ORcourse because ANDcourse will change
# all of its children's plan arguments to a single course.
class SameCourseRule < CourseFilter
  def check_course(plan, course, entries, flags=[], fulfilling_set)
    Rule.parse_entries(entries).each do |rule, args|
      return false unless rule.check course, args, flags, fulfilling_set
    end
    true
  end
end
Rule.add(SameCourseRule.new :same_course)
