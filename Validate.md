# Các loại Validation thường dùng trong Ruby on Rails

Trong Ruby on Rails, các loại **validation** thường được sử dụng để đảm bảo dữ liệu nhập vào tuân thủ các ràng buộc hoặc quy tắc được chỉ định. Dưới đây là các loại validation phổ biến:

---

## 1. Validation cơ bản

### Presence
Đảm bảo giá trị không được để trống.
```ruby
validates :name, presence: true
```

### Length
Giới hạn độ dài của giá trị.
```ruby
validates :password, length: { minimum: 6, maximum: 20 }
```

### Numericality
Đảm bảo giá trị là số (hoặc đáp ứng điều kiện số).
```ruby
validates :age, numericality: { only_integer: true, greater_than: 0 }
```

### Uniqueness
Đảm bảo giá trị là duy nhất trong cơ sở dữ liệu.
```ruby
validates :email, uniqueness: true
```
> **Lưu ý:** Nên thêm **index unique** trong cơ sở dữ liệu để đảm bảo tính toàn vẹn.

### Inclusion
Giá trị phải nằm trong danh sách được chỉ định.
```ruby
validates :status, inclusion: { in: %w[active inactive] }
```

### Exclusion
Giá trị không được nằm trong danh sách chỉ định.
```ruby
validates :username, exclusion: { in: %w[admins superuser] }
```

---

## 2. Validation định dạng

### Format
Kiểm tra giá trị khớp với biểu thức chính quy (regex).
```ruby
validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
```

---

## 3. Custom Validation
Tạo validation riêng để xử lý các logic phức tạp.
```ruby
validate :check_custom_condition

def check_custom_condition
  errors.add(:base, "Lỗi tùy chỉnh!") if some_invalid_condition?
end
```

---

## 4. Conditional Validation
Dùng các điều kiện để kiểm soát khi nào validation được áp dụng.

### Sử dụng `if` và `unless`
```ruby
validates :email, presence: true, if: -> { user_type == 'admins' }
validates :phone_number, presence: true, unless: -> { user_type == 'guest' }
```

---

## 5. Validation liên quan

### Associated
Đảm bảo đối tượng liên kết cũng hợp lệ.
```ruby
validates_associated :profile
```

---

## 6. Acceptance
Được dùng cho checkbox hoặc thỏa thuận.
```ruby
validates :terms_of_service, acceptance: true
```

---

## 7. Confirmation
Đảm bảo hai giá trị khớp nhau, ví dụ mật khẩu.
```ruby
validates :password, confirmation: true
```

---

## 8. Presence với Allow Nil/Blank
Dùng để kiểm soát các giá trị nil hoặc blank.
```ruby
validates :bio, length: { maximum: 500 }, allow_blank: true
```

---

## 9. Uniqueness với Scope
Thêm điều kiện khi kiểm tra tính duy nhất.
```ruby
validates :email, uniqueness: { scope: :account_id }
```

---

## 10. Active Record Callbacks
Kết hợp validation với callback để xử lý logic trước khi lưu.
```ruby
before_validation :normalize_name

def normalize_name
  self.name = name.strip.titleize if name.present?
end
```

---

## Lưu ý
- Sử dụng validation ở cấp database để đảm bảo dữ liệu nhất quán.
- Dùng gem hỗ trợ như **`validates_email_format_of`** hoặc **`shoulda-matchers`** để kiểm tra.

---

**Bạn có thể tùy chỉnh thêm validation để phù hợp với dự án của mình!**

