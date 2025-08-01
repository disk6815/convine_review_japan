import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["categorySelect"]

  connect() {
    console.log('=== Select2 Controller Connected ===')
    console.log('Controller element:', this.element)
    console.log('Available targets:', this.targets)
    console.log('Category select target exists:', this.hasCategorySelectTarget)
    this.initializeSelect2()
  }

  disconnect() {
    if (this.select2Instance) {
      console.log('Destroying Select2 instance')
      this.select2Instance.destroy()
    }
  }

  initializeSelect2() {
    console.log('Window width:', window.innerWidth)
    console.log('Category select target:', this.categorySelectTarget)
    
    // 既存のSelect2インスタンスを破棄
    if (this.select2Instance) {
      this.select2Instance.destroy()
    }
    
    // スマホサイズでのみSelect2を有効化
    if (window.innerWidth < 768) {
      console.log('Initializing Select2 for mobile')
      try {
        // DOM要素が存在するか確認
        if (this.categorySelectTarget) {
          this.select2Instance = $(this.categorySelectTarget).select2({
            placeholder: "カテゴリーを選択してください",
            allowClear: true,
            width: '100%',
            multiple: true,
            closeOnSelect: false,
            language: {
              noResults: function() {
                return "結果が見つかりません";
              }
            }
          })
          console.log('Select2 initialized successfully')
        } else {
          console.error('Category select target not found')
        }
      } catch (error) {
        console.error('Error initializing Select2:', error)
      }
    } else {
      console.log('Desktop view - Select2 not needed')
    }
  }
} 