// ambient speed lines
  const container = document.getElementById('speedlines');
  const count = 14;
  for(let i=0;i<count;i++){
    const s = document.createElement('span');
    s.style.top = (Math.random()*100)+'%';
    s.style.animationDuration = (3+Math.random()*4)+'s';
    s.style.animationDelay = (Math.random()*5)+'s';
    s.style.opacity = (0.2+Math.random()*0.5);
    container.appendChild(s);
  }

  // scroll reveal
  const revealEls = document.querySelectorAll('.reveal');
  const io = new IntersectionObserver((entries)=>{
    entries.forEach(e=>{
      if(e.isIntersecting){
        e.target.classList.add('in-view');
      }
    });
  },{threshold:0.15});
  revealEls.forEach(el=>io.observe(el));