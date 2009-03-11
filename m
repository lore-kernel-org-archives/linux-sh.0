From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 11 Mar 2009 04:26:49 +0000
Subject: Re: [PATCH] sh: hibernation support
Message-Id: <aec7e5c30903102126y53e0ee09r332ac3409f41329c@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0003255760b2bb78510464d046a4"
List-Id: <linux-sh.vger.kernel.org>
References: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
To: linux-sh@vger.kernel.org

--0003255760b2bb78510464d046a4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Francesco,

On Tue, Mar 10, 2009 at 10:19 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
> Hi Magnus
> In the clock framework I would propose the attached solution

Thanks for your help! I tested your patch but I need the attached fix.

Can you please include my fix and resubmit inline? Feel free to add an
ack from me.

Thanks!

/ magnus

--0003255760b2bb78510464d046a4
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0003-sh_clk-Added-clks-sysdevice-to-support-hibernation-fix.patch"
Content-Disposition: attachment; 
	filename="0003-sh_clk-Added-clks-sysdevice-to-support-hibernation-fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fs5ia85m1

LS0tIDAwMDMvYXJjaC9zaC9rZXJuZWwvY3B1L2Nsb2NrLmMKKysrIHdvcmsvYXJjaC9zaC9rZXJu
ZWwvY3B1L2Nsb2NrLmMJMjAwOS0wMy0xMSAxMjozNjo0NC4wMDAwMDAwMDAgKzA5MDAKQEAgLTM2
OSw3ICszNjksNyBAQCBzdGF0aWMgaW50IGNsa3NfcmVzdW1lKHN0cnVjdCBzeXNfZGV2aWNlCiB9
CiAKIHN0YXRpYyBzdHJ1Y3Qgc3lzZGV2X2NsYXNzIGNsa3NfY2xhc3MgPSB7Ci0JLmtzZXQua29i
ai5uYW1lID0gImNsa3MiLAorCS5uYW1lID0gImNsa3MiLAogfTsKIAogc3RhdGljIHN0cnVjdCBz
eXNkZXZfZHJpdmVyIGNsa3NfZHJpdmVyID0gewpAQCAtNDA1LDEwICs0MDUsMTAgQEAgaW50IF9f
aW5pdCBjbGtfaW5pdCh2b2lkKQogCiBzdGF0aWMgaW50IF9faW5pdCBjbGtfc3lzZGV2X2luaXQo
dm9pZCkKIHsKLQogCXN5c2Rldl9jbGFzc19yZWdpc3RlcigmY2xrc19jbGFzcyk7CiAJc3lzZGV2
X2RyaXZlcl9yZWdpc3RlcigmY2xrc19jbGFzcywgJmNsa3NfZHJpdmVyKTsKIAlzeXNkZXZfcmVn
aXN0ZXIoJmNsa3NfZGV2KTsKKwogCXJldHVybiAwOwogfQogc3Vic3lzX2luaXRjYWxsKGNsa19z
eXNkZXZfaW5pdCk7Cg==
--0003255760b2bb78510464d046a4--
