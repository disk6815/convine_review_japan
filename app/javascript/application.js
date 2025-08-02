// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

console.log('Application.js loaded!');

// Select2初期化関数
function initializeSelect2() {
  console.log('Select2初期化開始');
  
  if (typeof $ === 'undefined') {
    console.log('jQuery is not available');
    return;
  }
  
  try {
    // 既存のselect2インスタンスを破棄
    $('.select2').select2('destroy');
  } catch (e) {
    console.log('Select2破棄エラー:', e);
  }
  
  // select2要素が存在するか確認
  const select2Elements = $('.select2');
  console.log('Select2要素数:', select2Elements.length);
  
  if (select2Elements.length > 0) {
    // 新しいselect2インスタンスを初期化
    select2Elements.select2({
      placeholder: 'カテゴリを選択してください',
      allowClear: true,
      width: '100%',
      language: 'ja',
      theme: 'default',
      closeOnSelect: false,
      multiple: true,
      tags: false
    });
    console.log('Select2初期化完了');
  } else {
    console.log('Select2要素が見つかりません');
  }
}

// ページ読み込み後に初期化
function setupSelect2() {
  console.log('Select2セットアップ開始');
  // 少し遅延させて初期化
  setTimeout(initializeSelect2, 500);
}

// 複数のイベントで初期化
document.addEventListener('DOMContentLoaded', () => {
  console.log('DOMContentLoaded event fired');
  setupSelect2();
});

document.addEventListener('turbo:load', () => {
  console.log('turbo:load event fired');
  setupSelect2();
});

document.addEventListener('turbo:render', () => {
  console.log('turbo:render event fired');
  setupSelect2();
});

document.addEventListener('turbo:frame-load', () => {
  console.log('turbo:frame-load event fired');
  setupSelect2();
});

// ページ読み込み完了時にも初期化
window.addEventListener('load', () => {
  console.log('load event fired');
  setupSelect2();
});

// 定期的にチェック（フォールバック）
setInterval(() => {
  if ($('.select2').length > 0 && !$('.select2').hasClass('select2-hidden-accessible')) {
    console.log('Select2要素を再初期化');
    initializeSelect2();
  }
}, 2000);