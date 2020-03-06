const chevrons = document.querySelectorAll('.task-down');

const initOpenTaskOnClick = () => {
  document.addEventListener('click', function(event) {
    if(event.target && event.target.classList.contains('task-down')){
      let task = event.target
      task.parentElement.children[1].classList.toggle("active");
      task.classList.toggle('flip')
      Array.from(task.children).forEach((child) => {
        if (task.classList.contains('flip')) {
          child.classList.remove('fa-chevron-down')
          child.classList.add('fa-chevron-up')
        } else {
          child.classList.remove('fa-chevron-up')
          child.classList.add('fa-chevron-down')
        }
      });}

      if(event.target && event.target.classList.contains('chevron')){
        let task = event.target.parentElement
        console.log(task)
        task.parentElement.children[1].classList.toggle("active");
        console.log(task.parentElement)
        console.log(task.parentElement.children)
        task.classList.toggle('flip')
        Array.from(task.children).forEach((child) => {
          if (task.classList.contains('flip')) {
            child.classList.remove('fa-chevron-down')
            child.classList.add('fa-chevron-up')
          } else {
            child.classList.remove('fa-chevron-up')
            child.classList.add('fa-chevron-down')
          }
        });
      }
    });
}
export { initOpenTaskOnClick }
