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
        console.log(task)
        task.classList.toggle('active')
        task.classList.toggle('submit-btn')
        task.parentElement.lastElementChild.firstElementChild.reset()
        task.parentElement.lastElementChild.classList.toggle('active')
        task.parentElement.lastElementChild.classList.toggle('submit-form')
      }

      if(event.target && event.target.classList.contains('grab-subtask-btn')){
        let task = event.target.closest('.new-subtask-btn')
        console.log(task)
        task.classList.toggle('active')
        task.classList.toggle('submit-btn')
        task.parentElement.lastElementChild.firstElementChild.reset()
        task.parentElement.lastElementChild.classList.toggle('active')
        task.parentElement.lastElementChild.classList.toggle('submit-form')
      }





    });
}

window.refresh = (querySelector,innerHTML) => {
  const element = document.querySelector(querySelector);
  element.innerHTML = innerHTML
}

window.refreshParent = (querySelector,innerHTML) => {
  const elementParent = document.querySelector(querySelector).parentElement;
  elementParent.innerHTML = innerHTML
}

window.refreshById = (id,innerHTML) => {
  const element= document.getElementById(id);
  element.innerHTML = innerHTML
}

export { initOpenTaskOnClick }
