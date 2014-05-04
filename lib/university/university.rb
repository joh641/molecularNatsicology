class University

  @@majors = {
    "Molecular Toxicology" => "CNR",
  }

  def self.get_college(major)
    @@majors[major]
  end

end