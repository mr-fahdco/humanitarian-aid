# Humanitarian Aid System

# نظام المساعدات الإنسانية - Aid System

<p align="center">
  <img src="https://img.shields.io/badge/version-1.0.0-blue" alt="Version">
  <img src="https://img.shields.io/badge/license-MIT-green" alt="License">
</p>

## 📌 وصف المشروع
نظام متكامل لإدارة المساعدات الإنسانية يهدف إلى تنظيم عمليات صرف المساعدات (النقدية والعينية) عبر بطاقات ذكية مزودة بباركود.  
يتميز النظام بما يلي:
- **إدارة المستفيدين** (تسجيل، بحث، تحديث).
- **إصدار بطاقات دائمة** تحدد الكمية السنوية المستحقة لكل مستفيد.
- **صرف المساعدات** مرتبط بسنة محددة، مع منع تكرار الصرف لنفس البطاقة في السنة نفسها.
- **إدارة المخازن والتوريدات** مع تحديث آلي للأرصدة عند الصرف أو التوريد.
- **نظام صلاحيات** متعدد المستويات للمستخدمين.
- **باركود فريد** لكل بطاقة لتسريع عمليات الصرف عبر المسح الضوئي.

## 🛠️ التقنيات المقترحة
- **الواجهة الخلفية (Backend)**:
  - ASP.NET Core 8+ (C#) مع Entity Framework Core – متوافق مع Uno Platform.
  - أو Node.js + Express.js مع TypeScript – متوافق مع Flutter و React Native.
- **قاعدة البيانات**: SQL Server / PostgreSQL / MySQL.
- **تطبيقات الجوال والويب (Cross-Platform)**:
  - [Uno Platform](https://platform.uno/) – لتوحيد الكود بين Android و iOS و Web (WebAssembly).
  - [Flutter](https://flutter.dev/) – خيار قوي مع دعم جيد للويب والجوال.
- **المصادقة**: JWT (JSON Web Tokens).
- **التوثيق**: Swagger / OpenAPI.

## 📂 محتويات المستودع
| الملف | الوصف |
|-------|-------|
| `README.md` | هذا الملف – نظرة عامة على المشروع |
| `DATABASE.md` | تحليل قاعدة البيانات (الجداول، الحقول، العلاقات) |
| `API.md` | توثيق واجهة API (نقاط النهاية، النماذج، الأخطاء) |

## 🚀 كيفية البدء للمطورين
1. **Fork** المستودع إلى حسابك على GitHub.
2. **استنساخ (Clone)** المستودع محلياً:
   ```bash
   git clone https://github.com/your-username/AidSystem-Analysis.git