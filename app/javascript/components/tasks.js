const tasks = document.querySelectorAll('.task-container');

if (tasks) {
  tasks.forEach((task) => {
    task.addEventListener('click', () => {
      task.lastElementChild.classList.toggle("active");
    });
  });
}

const checkboxes = document.querySelectorAll('.check .far');
if (checkboxes) {
  checkboxes.forEach((checkbox) => {
    checkbox.addEventListener('click', (event) => {
      event.stopPropagation()
      if (checkbox.classList.value == 'far fa-check-square') {
        checkbox.classList.remove('fa-check-square')
        checkbox.classList.add('fa-square')
      } else {
        checkbox.classList.remove('fa-square')
        checkbox.classList.add('fa-check-square')
      }
    });
  });
}
