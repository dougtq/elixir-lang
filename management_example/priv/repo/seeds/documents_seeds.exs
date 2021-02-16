alias ManagementExample.Repo
alias ManagementExample.Management.Document

Repo.insert! %Document {
  name: "Gutember",
  content: "This is a project for wordpress",
  project_id: 1
}

Repo.insert! %Document {
  name: "Full Cycle",
  content: "Understanding more about each phase of an app",
  project_id: 2
}

Repo.insert! %Document {
  name: "Rust",
  content: "Understanding more about this great language",
  project_id: 3,
  published: true,
  view_count: 7
}
