alias TodoList.Repo
alias TodoList.Todos.Item

Repo.insert! %Item {
  content: "Learn Rust"
}

Repo.insert! %Item {
  content: "Learn Elixir"
}

Repo.insert! %Item {
  content: "Learn Golang",
}
