const initOpenTaskOnClick = () => {
  document.addEventListener('click', function(event) {
    console.log(event.target.closest('.new-subtask-btn'))
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
        });
      }

      if(event.target && event.target.classList.contains('new-subtask-btn')){
        let task = event.target

        task.classList.toggle('active')
        task.classList.toggle('submit-btn')
        console.log(task)
        console.log(task.parentElement)
        console.log(task.parentElement.lastElementChild.firstElementChild)
        task.parentElement.lastElementChild.firstElementChild.reset()
        task.parentElement.lastElementChild.classList.toggle('active')
        task.parentElement.lastElementChild.classList.toggle('submit-form')
      }

      if(event.target && event.target.classList.contains('grab-btn')){
        let task = event.target.closest('.new-subtask-btn')

        task.classList.toggle('active')
        task.classList.toggle('submit-btn')
        console.log(task)
        console.log(task.parentElement)
        console.log(task.parentElement.lastElementChild.firstElementChild)
        task.parentElement.lastElementChild.firstElementChild.reset()
        task.parentElement.lastElementChild.classList.toggle('active')
        task.parentElement.lastElementChild.classList.toggle('submit-form')
      }

      // if(event.target && event.target.classList.contains('edit-btn')){
      //   let task = event.target.closest('.subtasks-col').parentElement.children[1]

      //   task.classList.toggle('active')
      //   task.classList.toggle('submit-btn')
      //   console.log(task)
      //   console.log(task.parentElement)
      //   console.log(task.parentElement.lastElementChild.firstElementChild)
      //   task.parentElement.lastElementChild.firstElementChild.reset()
      //   task.parentElement.lastElementChild.classList.toggle('active')
      //   task.parentElement.lastElementChild.classList.toggle('submit-form')
      // }






    });
}
export { initOpenTaskOnClick }
