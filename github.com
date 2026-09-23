<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>약속땃지ni - 약속 스케줄 정해준다쮜><</title>
  <style>
    :root {
      --primary-color: #ff7b54;
      --secondary-color: #ffb26b;
      --bg-color: #fff6ea;
      --card-bg: #ffffff;
      --text-color: #333;
      --danger-color: #e74c3c;
    }

    * { box-sizing: border-box; font-family: 'Pretendard', sans-serif, Arial; }
    body { background-color: var(--bg-color); color: var(--text-color); margin: 0; padding: 20px; display: flex; justify-content: center; }
    
    .app-container {
      width: 100%;
      max-width: 500px;
      background: var(--card-bg);
      border-radius: 20px;
      padding: 24px;
      box-shadow: 0 10px 25px rgba(0,0,0,0.08);
      position: relative;
    }

    .header { text-align: center; margin-bottom: 24px; }
    .header h1 { margin: 0; color: var(--primary-color); font-size: 1.8rem; }
    .header p { margin: 6px 0 0; color: #777; font-size: 0.9rem; }

    .step-card {
      display: none;
      animation: fadeIn 0.3s ease-in-out forwards;
    }
    .step-card.active { display: block; }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .form-group { margin-bottom: 16px; }
    .form-group label { display: block; font-weight: bold; margin-bottom: 8px; font-size: 0.95rem; }
    .form-control {
      width: 100%;
      padding: 12px;
      border: 2px solid #eee;
      border-radius: 10px;
      font-size: 0.95rem;
      outline: none;
      transition: border-color 0.2s;
    }
    .form-control:focus { border-color: var(--primary-color); }

    .grid-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }

    .btn {
      width: 100%;
      padding: 14px;
      border: none;
      border-radius: 10px;
      background-color: var(--primary-color);
      color: white;
      font-size: 1rem;
      font-weight: bold;
      cursor: pointer;
      margin-top: 10px;
      transition: background-color 0.2s;
    }
    .btn:hover { background-color: #e66a43; }

    /* 땃쥐 대화창 / 분노 모듈 */
    .tatji-box {
      background: #fbf0e4;
      border: 2px dashed var(--secondary-color);
      border-radius: 15px;
      padding: 16px;
      margin-bottom: 20px;
      display: flex;
      align-items: center;
      gap: 12px;
      position: relative;
    }
    .tatji-avatar {
      font-size: 2.5rem;
      background: #fff;
      border-radius: 50%;
      width: 55px;
      height: 55px;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
    }
    .tatji-msg { font-size: 0.9rem; line-height: 1.4; color: #444; }

    .angry-level-1 { border-color: #f39c12; background: #fffdf5; }
    .angry-level-2 { border-color: #e67e22; background: #fff5eb; }
    .angry-level-3 { border-color: var(--danger-color); background: #fdf2f2; color: var(--danger-color); }

    /* 코스 결과 스타일 */
    .timeline { position: relative; padding-left: 20px; margin-top: 15px; border-left: 3px solid var(--secondary-color); }
    .timeline-item { position: relative; margin-bottom: 15px; padding-left: 15px; }
    .timeline-item::before {
      content: '';
      position: absolute;
      left: -26px;
      top: 2px;
      width: 12px;
      height: 12px;
      border-radius: 50%;
      background: var(--primary-color);
    }
    .timeline-item h4 { margin: 0 0 4px; font-size: 1rem; }
    .timeline-item p { margin: 0; color: #666; font-size: 0.85rem; }

    .complain-section {
      margin-top: 20px;
      border-top: 1px solid #eee;
      padding-top: 15px;
    }
  </style>
</head>
<body>

<div class="app-container">
  <div class="header">
    <h1>약속땃지ni 🐭</h1>
    <p>도파민 절약! 땃쥐가 약속 스케줄을 정해준다쮜><</p>
  </div>

  <!-- STEP 1: 위치 및 시간 -->
  <div id="step-1" class="step-card active">
    <div class="tatji-box">
      <div class="tatji-avatar">🐭</div>
      <div class="tatji-msg">안녕하쮜! 도파민 쓰지 말고 나한테 맡겨라쮜! 어디서 출발하는지랑 몇 시간 놀 수 있는지 말해라쮜!</div>
    </div>

    <div class="form-group">
      <label>내 출발 위치</label>
      <input type="text" id="myLocation" class="form-control" placeholder="예: 강남역, 우리집">
    </div>
    <div class="form-group">
      <label>친구 출발 위치</label>
      <input type="text" id="friendLocation" class="form-control" placeholder="예: 홍대입구역, 학원">
    </div>
    <div class="form-group">
      <label>놀 수 있는 여유 시간 (시간)</label>
      <input type="number" id="playTime" class="form-control" placeholder="예: 3" min="1" max="24">
    </div>

    <button class="btn" onclick="nextStep(2)">다음으로 넘어가기쮜 ></button>
  </div>

  <!-- STEP 2: 취향 및 MBTI -->
  <div id="step-2" class="step-card">
    <div class="tatji-box">
      <div class="tatji-avatar">🐭</div>
      <div class="tatji-msg">취향이랑 MBTI도 알려줘야 딱 맞게 짜준다쮜! 틀리면 억지로 끌고갈 거다쮜!</div>
    </div>

    <div class="grid-2">
      <div class="form-group">
        <label>내 MBTI</label>
        <input type="text" id="myMbti" class="form-control" placeholder="예: ENFP" maxlength="4">
      </div>
      <div class="form-group">
        <label>친구 MBTI</label>
        <input type="text" id="friendMbti" class="form-control" placeholder="예: ISTJ" maxlength="4">
      </div>
    </div>

    <div class="form-group">
      <label>선호하는 놀이 스타일</label>
      <select id="playStyle" class="form-control">
        <option value="active">활동적 (방탈출, 액티비티, 춤)</option>
        <option value="food">맛집 탐방 (핫플, 디저트, 맛집)</option>
        <option value="quiet">정적인 활동 (보드게임, 북카페, 산책)</option>
        <option value="random">도파민 폭발 (알아서 다 섞어줘)</option>
      </select>
    </div>

    <button class="btn" onclick="calculateCourse()">AI 분석 시작 및 코스 짜기쮜!</button>
  </div>

  <!-- STEP 3 & 4: 최적 장소 및 결과 / 불평 땃쥐 모듈 -->
  <div id="step-3" class="step-card">
    <div id="tatjiBox" class="tatji-box">
      <div id="tatjiAvatar" class="tatji-avatar">🐭</div>
      <div id="tatjiMsg" class="tatji-msg">열심히 머리 굴려서 동선 최적화 코스 완료했다쮜! 토 달지 말고 이대로 놀아라쮜!</div>
    </div>

    <h3>📍 추천 중간 지점: <span id="midPointResult" style="color:var(--primary-color);"></span></h3>
    
    <div class="timeline" id="courseTimeline">
      <!-- 동적 코스 리스트 출력 영역 -->
    </div>

    <!-- 땃쥐 조련/화내기 섹션 -->
    <div class="complain-section">
      <div class="form-group">
        <label style="color:#666; font-size:0.85rem;">맘에 안 들면 불평해보든가쮜 (땃쥐의 분노 게이지 상승)</label>
        <input type="text" id="complainInput" class="form-control" placeholder="예: 이동 시간이 너무 길어, 다른 거 할래">
      </div>
      <button class="btn" style="background-color:#666;" onclick="complainToTatji()">땃쥐한테 불만 제기하기 💣</button>
    </div>
  </div>
</div>

<script>
  let angerLevel = 0;

  function nextStep(step) {
    if(step === 2) {
      const myLoc = document.getElementById('myLocation').value;
      const friendLoc = document.getElementById('friendLocation').value;
      const time = document.getElementById('playTime').value;

      if(!myLoc || !friendLoc || !time) {
        alert("위치랑 여유 시간을 다 입력해라쮜!");
        return;
      }
    }
    
    document.querySelectorAll('.step-card').forEach(el => el.classList.remove('active'));
    document.getElementById(`step-${step}`).classList.add('active');
  }

  function calculateCourse() {
    const myLoc = document.getElementById('myLocation').value;
    const friendLoc = document.getElementById('friendLocation').value;
    const time = parseInt(document.getElementById('playTime').value);
    const myMbti = document.getElementById('myMbti').value.toUpperCase();
    const friendMbti = document.getElementById('friendMbti').value.toUpperCase();
    const style = document.getElementById('playStyle').value;

    if(!myMbti || !friendMbti) {
      alert("MBTI를 제대로 입력해라쮜!");
      return;
    }

    // 중간 지점 단순 추론 로직 (시뮬레이션)
    const midPoint = `${myLoc}와 ${friendLoc} 사이의 핫플레이스`;
    document.getElementById('midPointResult').innerText = midPoint;

    // 코스 생성
    const timeline = document.getElementById('courseTimeline');
    timeline.innerHTML = '';

    let courses = [];
    if(style === 'active') {
      courses = ['익스트림 방탈출 카페', '보상용 맛집 타임', '루프탑 액티비티 바'];
    } else if(style === 'food') {
      courses = ['인스타 핫플 감성 식당', '디저트 미슐랭 카페', '소품샵 산책 & 구경'];
    } else if(style === 'quiet') {
      courses = ['조용한 북카페 / 만화카페', '잔잔한 호수공원 산책', '아늑한 보드게임룸'];
    } else {
      courses = ['랜덤 맛집 급습', '코인노래방 도파민 파티', '심야 영화 감상'];
    }

    // MBTI 특성 반영 문구 추가
    let mbtiNote = "";
    if(myMbti.includes('I') || friendMbti.includes('I')) {
      mbtiNote = " (I 성향을 고려해 기진맥진하지 않도록 쉼터 배치!)";
    } else if(myMbti.includes('P') && friendMbti.includes('P')) {
      mbtiNote = " (P 둘이 만났으니 융통성 있게 이동 동선 최소화!)";
    }

    courses.forEach((item, index) => {
      const itemEl = document.createElement('div');
      itemEl.className = 'timeline-item';
      itemEl.innerHTML = `
        <h4>STEP ${index + 1}. ${item}</h4>
        <p>약 ${Math.floor(time / courses.length)}시간 소요 예정${index === 0 ? mbtiNote : ''}</p>
      `;
      timeline.appendChild(itemEl);
    });

    nextStep(3);
  }

  // 사회에 찌든 땃쥐의 분노 로직
  function complainToTatji() {
    const input = document.getElementById('complainInput');
    const msgBox = document.getElementById('tatjiMsg');
    const avatar = document.getElementById('tatjiAvatar');
    const container = document.getElementById('tatjiBox');

    if(!input.value.trim()) {
      alert("불만을 입력하고 말을 걸라쮜!");
      return;
    }

    angerLevel++;
    input.value = '';

    if(angerLevel === 1) {
      container.className = 'tatji-box angry-level-1';
      avatar.innerText = '😾';
      msgBox.innerText = "하... 또 또 불평이지? 야, 최적 동선으로 짜준 것도 감지덕지해야지 뭐라는 거냐쮜?! 그냥 군말 말고 가라쮜!";
    } else if(angerLevel === 2) {
      container.className = 'tatji-box angry-level-2';
      avatar.innerText = '🤬';
      msgBox.innerText = "야!!! 나도 사회생활하느라 피곤해 죽겠는데 또 토 달아?! 니들이 직접 정하든가! 싫으면 그냥 집에나 있어라쮜!!!";
    } else {
      container.className = 'tatji-box angry-level-3';
      avatar.innerText = '💀';
      msgBox.innerText = "아 빡치게 하지 마라 진짜... 🔥 더 이상 수정은 없다!! 이 코스로 강제 확정이다쮜!! 3초 내로 출발 안 하면 다 물어뜯는다쮜!!!";
      document.querySelector('.complain-section').style.display = 'none'; // 버튼 차단
    }
  }
</script>

</body>
</html>
