alias ManagementExample.Repo
alias ManagementExample.Management.Project

Repo.insert! %Project {
  title: "Gutember",
  description: "This is a project for wordpress"
}

Repo.insert! %Project {
  title: "Full Cycle",
  description: "Understanding more about each phase of an app"
}

Repo.insert! %Project {
  title: "Rust",
  description: "Understanding more about this great language"
}
