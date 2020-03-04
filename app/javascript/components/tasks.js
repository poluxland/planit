
const chevrons = document.querySelectorAll('.task-down');
const initOpenTaskOnClick = () => {
  if (chevrons) {
    chevrons.forEach((chevron) => {
      chevron.addEventListener('click', () => {
        chevron.parentElement.children[1].classList.toggle("active");
        chevron.classList.toggle('active')
        Array.from(chevron.children).forEach((child) => {
          if (chevron.classList.contains('active')) {
            child.classList.remove('fa-chevron-down')
            child.classList.add('fa-chevron-up')
          } else {
            child.classList.remove('fa-chevron-up')
            child.classList.add('fa-chevron-down')
          }

        });
      });
      });
    }
  };

  export { initOpenTaskOnClick }
