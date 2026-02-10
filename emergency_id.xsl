<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
    <html lang="zh-Hant">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Emergency ID - <xsl:value-of select="emergency_id/user_info/name"/></title>
        <style>
            :root { 
                --primary: #94806a; 
                --primary-dark: #7a6955;
                --bg: #c2b09d; 
                --card-white: #ffffff; 
                --item-bg: #f8f6f4;
                --text-main: #5a544d; 
                --accent: #8b4513; 
            }
            body { 
                font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; 
                background-color: var(--bg); margin: 0; padding: 20px; 
                display: flex; flex-direction: column; align-items: center; 
            }
            .lang-selector { margin-bottom: 20px; width: 100%; max-width: 400px; }
            select { 
                width: 100%; padding: 14px; border-radius: 15px; 
                background: var(--card-white); color: var(--primary-dark); 
                font-weight: bold; font-size: 16px; border: none; 
                box-shadow: 0 4px 10px rgba(0,0,0,0.1); outline: none;
            }
            .card { 
                width: 100%; max-width: 400px; background: var(--card-white); 
                border-radius: 30px; box-shadow: 0 20px 40px rgba(0,0,0,0.15); 
                overflow: hidden; 
            }
            /* 頂部深色區域 */
            .header-sec { 
                background: var(--primary); padding: 40px 20px; text-align: center; color: white;
            }
            .profile-img { 
                width: 130px; height: 130px; object-fit: cover; 
                border: 5px solid rgba(255,255,255,0.3); border-radius: 50%; 
                margin-bottom: 15px; box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            }
            .user-name { margin: 0; font-size: 24px; letter-spacing: 1px; }
            .ui-title-text { font-size: 14px; opacity: 0.9; margin-bottom: 10px; display: block; }

            .content { padding: 25px; }
            .section-title { 
                font-size: 12px; color: var(--primary); font-weight: 800; 
                margin: 20px 0 10px; text-transform: uppercase; letter-spacing: 1px;
                display: flex; align-items: center;
            }
            .section-title::after { content: ""; flex: 1; height: 1px; background: #eee; margin-left: 10px; }

            .item { 
                background: var(--item-bg); padding: 12px 15px; 
                border-radius: 15px; margin-bottom: 8px; display: flex; 
                flex-direction: column; 
            }
            .label { font-size: 10px; color: #a09384; font-weight: bold; margin-bottom: 2px; }
            .value { font-size: 16px; color: var(--text-main); font-weight: 600; }
            
            .help-box { 
                background: #fff0f0; padding: 20px; border-radius: 20px; 
                border: 1px dashed #feb2b2; margin-top: 20px; text-align: center; 
            }
            .help-text { color: #c53030; font-weight: bold; font-size: 16px; line-height: 1.4; }

            .footer { text-align: center; font-size: 11px; color: #94806a; padding: 25px; opacity: 0.7; }
        </style>
    </head>
    <body>
        <div class="lang-selector">
            <select id="langSelect" onchange="changeLanguage()">
                <option value="zh">🇹🇼 中文 (Traditional Chinese)</option>
                <option value="en">🇺🇸 English</option>
                <option value="jp">🇯🇵 日本語</option>
                <option value="kr">🇰🇷 한국어</option>
                <option value="vn">🇻🇳 Tiếng Việt</option>
                <option value="th">🇹🇭 ภาษาไทย</option>
                <option value="fr">🇫🇷 Français</option>
                <option value="de">🇩🇪 Deutsch</option>
            </select>
        </div>

        <div class="card">
            <div class="header-sec">
                <span class="ui-title-text" id="ui-title">緊急個人資訊</span>
                <img src="photo.jpg" class="profile-img" onerror="this.src='https://via.placeholder.com/130?text=USER'" />
                <h2 class="user-name"><xsl:value-of select="emergency_id/user_info/name"/></h2>
            </div>
            
            <div class="content">
                <div class="section-title" id="sec-basic">Basic Info</div>
                <div class="item"><span class="label" id="lbl-dob">出生日期</span><span class="value"><xsl:value-of select="emergency_id/user_info/dob"/></span></div>
                <div class="item"><span class="label" id="lbl-passport">護照號碼</span><span class="value"><xsl:value-of select="emergency_id/user_info/passport"/></span></div>
                <div class="item"><span class="label" id="lbl-blood">血型</span><span class="value" style="color:var(--accent)"><xsl:value-of select="emergency_id/user_info/blood_type"/></span></div>

                <div class="section-title" id="sec-medical">Medical Info</div>
                <div class="item"><span class="label" id="lbl-allergy">過敏紀錄</span><span class="value"><xsl:value-of select="emergency_id/medical_details/allergy"/></span></div>
                <div class="item"><span class="label" id="lbl-history">病史</span><span class="value"><xsl:value-of select="emergency_id/medical_details/history"/></span></div>

                <div class="section-title" id="sec-contact">Emergency Contact</div>
                <div class="item">
                    <span class="label" id="lbl-ice">緊急聯絡人</span>
                    <span class="value">
                        <xsl:for-each select="emergency_id/contacts/contact">
                            <div style="font-size:14px; margin-top:4px;">
                                <b style="color:var(--primary)"><xsl:value-of select="@role"/>:</b> <xsl:value-of select="."/>
                            </div>
                        </xsl:for-each>
                    </span>
                </div>
                
                <div class="help-box">
                    <div class="help-text" id="val-help">"我不舒服，請幫我叫救護車。"</div>
                </div>
            </div>
            <div class="footer" id="ui-footer">Last Updated: <xsl:value-of select="emergency_id/user_info/last_update"/></div>
        </div>

        <script>
            const translations = {
                zh: { title: "緊急個人資訊", s1: "基本資料", s2: "醫療資訊", s3: "緊急聯絡", dob: "出生日期", passport: "護照號碼", blood: "血型", allergy: "過敏紀錄", history: "病史", ice: "聯絡人", help: "「我不舒服，請幫我叫救護車。」" },
                en: { title: "EMERGENCY ID", s1: "BASIC INFO", s2: "MEDICAL INFO", s3: "CONTACTS", dob: "Date of Birth", passport: "Passport No.", blood: "Blood Type", allergy: "Allergies", history: "Medical History", ice: "ICE Contacts", help: '"I feel unwell. Please call an ambulance."' },
                jp: { title: "緊急医療情報", s1: "基本情報", s2: "医療情報", s3: "緊急連絡先", dob: "生年月日", passport: "パスポート番号", blood: "血液型", allergy: "アレルギー", history: "既往歴", ice: "連絡先", help: "「気分が悪いです。救急車を呼んでください。」" },
                kr: { title: "긴급 의료 정보", s1: "기본 정보", s2: "의료 정보", s3: "비상 연락처", dob: "생년월일", passport: "여권 번호", blood: "혈액형", allergy: "알레르기", history: "병력", ice: "비상 연락처", help: '"몸이 안 좋습니다. 구급차를 불러주세요."' },
                vn: { title: "THÔNG TIN KHẨN CẤP", s1: "THÔNG TIN CƠ BẢN", s2: "Y TẾ", s3: "LIÊN HỆ", dob: "Ngày sinh", passport: "Số hộ chiếu", blood: "Nhóm máu", allergy: "Dị ứng", history: "Tiền sử", ice: "Liên hệ khẩn cấp", help: '"Tôi cảm thấy không khỏe. Vui lòng gọi xe cứu thương."' },
                th: { title: "ข้อมูลฉุกเฉิน", s1: "ข้อมูลพื้นฐาน", s2: "ข้อมูลการแพทย์", s3: "ติดต่อฉุกเฉิน", dob: "วันเกิด", passport: "หมายเลขพาสปอร์ต", blood: "กรุ๊ปเลือด", allergy: "แพ้ยา", history: "ประวัติการรักษา", ice: "ติดต่อฉุกเฉิน", help: '"ฉันรู้สึกไม่สบาย โปรดเรียกรถพยาบาล"' },
                fr: { title: "ID D'URGENCE", s1: "INFOS DE BASE", s2: "INFOS MÉDICALES", s3: "CONTACTS", dob: "Date de naissance", passport: "Passeport n°", blood: "Groupe Sanguin", allergy: "Allergies", history: "Antécédents", ice: "Contact d'urgence", help: '"Je ne me sens pas bien. Appelez une ambulance."' },
                de: { title: "NOTFALLAUSWEIS", s1: "BASISINFOS", s2: "MEDIZINISCHE DATEN", s3: "KONTAKTE", dob: "Geburtsdatum", passport: "Reisepass-Nr.", blood: "Blutgruppe", allergy: "Allergien", history: "Krankengeschichte", ice: "Notfallkontakt", help: '"Ich fühle mich nicht gut. Bitte rufen Sie einen Krankenwagen."' }
            };

            function changeLanguage() {
                const lang = document.getElementById('langSelect').value;
                const t = translations[lang];
                document.getElementById('ui-title').innerText = t.title;
                document.getElementById('sec-basic').innerText = t.s1;
                document.getElementById('sec-medical').innerText = t.s2;
                document.getElementById('sec-contact').innerText = t.s3;
                document.getElementById('lbl-dob').innerText = t.dob;
                document.getElementById('lbl-passport').innerText = t.passport;
                document.getElementById('lbl-blood').innerText = t.blood;
                document.getElementById('lbl-allergy').innerText = t.allergy;
                document.getElementById('lbl-history').innerText = t.history;
                document.getElementById('lbl-ice').innerText = t.ice;
                document.getElementById('val-help').innerText = t.help;
            }
            window.onload = changeLanguage;
        </script>
    </body>
    </html>
</xsl:template>
</xsl:stylesheet>