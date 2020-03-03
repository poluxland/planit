const initOpenTaskOnClick = () => {
  const tasks = document.querySelectorAll('.card-product');
  if (tasks) {
    tasks.forEach((task) => {
      task.addEventListener('click', () => {
        task.classList.toggle('active');
      });
    });
  }
}

export { initOpenTaskOnClick };
