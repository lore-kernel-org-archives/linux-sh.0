From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 01 Aug 2013 09:51:56 +0000
Subject: Re: [RFC 0/5] Non-functional zboot implementation for KZM9G
Message-Id: <CANqRtoShy5rvo58AZcwbwF-au58aQuamhSdXkb3_e=ok1+pVVA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="001a11c2432ae8e03804e2dfca2c"
List-Id: <linux-sh.vger.kernel.org>
References: <1375207047-8655-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1375207047-8655-1-git-send-email-ulrich.hecht@gmail.com>
To: linux-sh@vger.kernel.org

--001a11c2432ae8e03804e2dfca2c
Content-Type: text/plain; charset=ISO-8859-1

Hi Ulrich,

On Wed, Jul 31, 2013 at 2:57 AM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
> Hi!
>
> This is an attempt to implement zboot on the KZM9G board. It is based on the
> setup code from u-boot and is intended to be loaded to MERAM via USB and
> booted by the mask ROM boot loader.
>
> The problem is that the DRAM setup appears to be wrong somehow. Even though
> it slavishly follows the example set by u-boot it fails to set the DRAM up
> in a stable manner for some reason.  The effect observed is that many
> consecutive writes to DRAM in most cases cause the system to hang.  In the
> few cases it doesn't the data written cannot be read back correctly.
>
> I have tried yanking every bit in the SBSC back and forth (see the
> commented-out lines in head-kzm9g.txt for details), but the DRAM stays flaky
> in exactly the same way.  I suspect that the mask ROM boot loader does
> something to the hardware that interferes with DRAM operation.  The sh73a0
> documentation details what the loader is supposed to be doing, and I have
> tried to revert the few things that are not overridden by the u-boot setup
> anyway, but that didn't to anything either.
>
> If you want to give it a try, apply the patches and configure your kernel
> with CONFIG_ZBOOT_ROM_BSS=0xe5580000 and CONFIG_ZBOOT_ROM=y.  You will have
> to disable a lot of features because MERAM is only 1.5 MB, and the entire
> image will have to fit in there.  Don't forget to append the DTB.  Set the
> mode switch (SW1) positions 1, 2, and 8 to OFF, all others to ON.  Then
> upload the zImage using Magnus' r_usb_tool.  If LEDs 1-4 light up and then
> turn off one by one, your board works better than mine.  If only LED 1 turns
> off or the LEDs start blinking crazy bit patterns, it exhibits the same
> behavior as mine.
>
> Ideas what could be wrong here are most welcome.

Thanks for posting your code. I will give your code a go when I find
time later on.

Until then, may I suggest that you try adding SCIF debug printouts by
yourself? LEDs are great, but it is hard to beat serial console...

For your convenience I've searched my pile of prototype patches and
I've attached 3 different examples of random SCIF output code for
various boards. For most of them you will need to hack them to change
base address and perhaps also location of TX FIFO register depending
on target SoC and board. Also, they assume that the boot loader
actually set up the SCIF and PFC for you already - this seems to be
the case with your zboot code but you may want to double check.

I think you should be able to use 3 instruction hack included in
"linux-3.12-pre-arm-shmobile-smp-mpidr-dbg-sh73a0-20130731b.patch" on
KZM9G more or less as-is.

Cheers,

/ magnus

--001a11c2432ae8e03804e2dfca2c
Content-Type: application/octet-stream; 
	name="linux-3.8-rc3-ape6-debug-ll-yoshii-20130110.patch"
Content-Disposition: attachment; 
	filename="linux-3.8-rc3-ape6-debug-ll-yoshii-20130110.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hjts1tjn0

RnJvbTogTWFnbnVzIERhbW0gPGRhbW1Ab3BlbnNvdXJjZS5zZT4KClNpZ25lZC1vZmYtYnk6IE1h
Z251cyBEYW1tIDxkYW1tQG9wZW5zb3VyY2Uuc2U+Ci0tLQoKIGFyY2gvYXJtL21hY2gtc2htb2Jp
bGUvaW5jbHVkZS9tYWNoL2RlYnVnLW1hY3JvLlMgfCAgIDQ3ICsrKysrKysrKysrKysrKysrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKykKCi0tLSAvZGV2L251bGwKKysrIHdv
cmsvYXJjaC9hcm0vbWFjaC1zaG1vYmlsZS9pbmNsdWRlL21hY2gvZGVidWctbWFjcm8uUwkyMDEz
LTAxLTEwIDIxOjMwOjQyLjAwMDAwMDAwMCArMDkwMApAQCAtMCwwICsxLDQ3IEBACisvKgorICog
YXJjaC9hcm0vbWFjaC1zaG1vYmlsZS9pbmNsdWRlL21hY2gvZGVidWctbWFjcm8uUworICoKKyAq
IERlYnVnZ2luZyBtYWNybyBpbmNsdWRlIGhlYWRlcgorICoKKyAqIENvcHlyaWdodCAoQykgMjAx
MiAgUmVuZXNhcyBFbGVjdHJvbmljcyBDb3Jwb3JhdGlvbgorICogQ29weXJpZ2h0IChDKSAxOTk0
LTE5OTkgUnVzc2VsbCBLaW5nCisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7
IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqIGl0IHVuZGVyIHRoZSB0
ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzCisgKiBw
dWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqLworCisjZGVmaW5l
IFNTUgkweDE0CisjZGVmaW5lIEZURFIJMHgyMAorCisjZGVmaW5lIFRERkUJKDEgPDwgNSkKKyNk
ZWZpbmUgVEVORAkoMSA8PCA2KQorCisvLyNpZmRlZiBDT05GSUdfTUFDSF9BUEU2RVZNCisjZGVm
aW5lIFNDSUZfUEhZUwkweGU2YzQwMDAwCisjZGVmaW5lIFNDSUZfVklSVAkweGU2YzQwMDAwCisv
LyNlbmRpZgorCisJLm1hY3JvCWFkZHJ1YXJ0LCBycCwgcnYsIHRtcAorCWxkcglccnAsID1TQ0lG
X1BIWVMKKwlsZHIJXHJ2LCA9U0NJRl9WSVJUCisJLmVuZG0KKworCS5tYWNybwl3YWl0dWFydCwg
cmQsIHJ4CisxMDAxOglsZHJoCVxyZCwgW1xyeCwgI1NTUl0KKwl0c3QJXHJkLCAjVERGRQorCWJl
cQkxMDAxYgorCS5lbmRtCisKKwkubWFjcm8Jc2VuZHVhcnQsIHJkLCByeAorCXN0cmIJXHJkLCBb
XHJ4LCAjRlREUl0KKwlsZHJoCVxyZCwgW1xyeCwgI1NTUl0KKwliaWMJXHJkLCBccmQsICNURU5E
CisJc3RyaAlccmQsIFtccngsICNTU1JdCisJLmVuZG0KKworCS5tYWNybwlidXN5dWFydCwgcmQs
IHJ4CisxMDAxOglsZHJoCVxyZCwgW1xyeCwgI1NTUl0KKwl0c3QJXHJkLCAjVEVORAorCWJlcQkx
MDAxYgorCS5lbmRtCg==
--001a11c2432ae8e03804e2dfca2c
Content-Type: application/octet-stream; 
	name="linux-3.8-rc3-ape6-compressed-loader-debug-hack-20130110b.patch"
Content-Disposition: attachment; 
	filename="linux-3.8-rc3-ape6-compressed-loader-debug-hack-20130110b.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hjts2jar1

RnJvbTogTWFnbnVzIERhbW0gPGRhbW1Ab3BlbnNvdXJjZS5zZT4KClNpZ25lZC1vZmYtYnk6IE1h
Z251cyBEYW1tIDxkYW1tQG9wZW5zb3VyY2Uuc2U+Ci0tLQoKIGFyY2gvYXJtL2Jvb3QvY29tcHJl
c3NlZC9oZWFkLlMgICAgICAgICAgICAgICAgICB8ICAgIDggKysrKysrKysKIGFyY2gvYXJtL2Jv
b3QvY29tcHJlc3NlZC9taXNjLmMgICAgICAgICAgICAgICAgICB8ICAgIDQgKysrLQogYXJjaC9h
cm0vbWFjaC1zaG1vYmlsZS9pbmNsdWRlL21hY2gvdW5jb21wcmVzcy5oIHwgICAxMSArKysrKysr
KysrKwogMyBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgot
LS0gMDAwMS9hcmNoL2FybS9ib290L2NvbXByZXNzZWQvaGVhZC5TCisrKyB3b3JrL2FyY2gvYXJt
L2Jvb3QvY29tcHJlc3NlZC9oZWFkLlMJMjAxMy0wMS0xMCAyMTowMzo1Mi4wMDAwMDAwMDAgKzA5
MDAKQEAgLTEzNCw2ICsxMzQsMTQgQEAgc3RhcnQ6CiAJCS53b3JkCV9lZGF0YQkJCUAgekltYWdl
IGVuZCBhZGRyZXNzCiAgVEhVTUIoCQkudGh1bWIJCQkpCiAxOgorI2RlZmluZSBTQ0lGVERSMCAw
eGU2YzQwMDIwCisKKwkJbW92CXIwLCAjMHhlNjAwMDAwMAorCQlhZGQJcjAsIHIwLCAjMHhjNDAw
MDAKKwkJYWRkCXIwLCByMCwgIzB4MjAKKwkJbW92ICAgICByMSwgIydYJworCQlzdHJiICAgIHIx
LCBbcjBdCisJCiAJCW1ycwlyOSwgY3BzcgogI2lmZGVmIENPTkZJR19BUk1fVklSVF9FWFQKIAkJ
YmwJX19oeXBfc3R1Yl9pbnN0YWxsCUAgZ2V0IGludG8gU1ZDIG1vZGUsIHJldmVyc2libHkKLS0t
IDAwMDIvYXJjaC9hcm0vYm9vdC9jb21wcmVzc2VkL21pc2MuYworKysgd29yay9hcmNoL2FybS9i
b290L2NvbXByZXNzZWQvbWlzYy5jCTIwMTMtMDEtMTAgMjE6MDM6NTIuMDAwMDAwMDAwICswOTAw
CkBAIC0zMCw3ICszMCw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBwdXRjKGludCBjKSB7fQogc3Rh
dGljIGlubGluZSB2b2lkIGZsdXNoKHZvaWQpIHt9CiBzdGF0aWMgaW5saW5lIHZvaWQgYXJjaF9k
ZWNvbXBfc2V0dXAodm9pZCkge30KICNlbHNlCi0jaW5jbHVkZSA8Li4vbWFjaC12ZXJzYXRpbGUv
aW5jbHVkZS9tYWNoL3VuY29tcHJlc3MuaD4KKyNpbmNsdWRlIDwuLi9tYWNoLXNobW9iaWxlL2lu
Y2x1ZGUvbWFjaC91bmNvbXByZXNzLmg+CiAjZW5kaWYKIAogI2lmZGVmIENPTkZJR19ERUJVR19J
Q0VEQ0MKQEAgLTE0OCw2ICsxNDgsOCBAQCBkZWNvbXByZXNzX2tlcm5lbCh1bnNpZ25lZCBsb25n
IG91dHB1dF9zCiAJZnJlZV9tZW1fZW5kX3B0cgk9IGZyZWVfbWVtX3B0cl9lbmRfcDsKIAlfX21h
Y2hpbmVfYXJjaF90eXBlCT0gYXJjaF9pZDsKIAorCXB1dGMoJ1gnKTsKKwogCWFyY2hfZGVjb21w
X3NldHVwKCk7CiAKIAlwdXRzdHIoIlVuY29tcHJlc3NpbmcgTGludXguLi4iKTsKLS0tIDAwMDEv
YXJjaC9hcm0vbWFjaC1zaG1vYmlsZS9pbmNsdWRlL21hY2gvdW5jb21wcmVzcy5oCisrKyB3b3Jr
L2FyY2gvYXJtL21hY2gtc2htb2JpbGUvaW5jbHVkZS9tYWNoL3VuY29tcHJlc3MuaAkyMDEzLTAx
LTEwIDIxOjA0OjA1LjAwMDAwMDAwMCArMDkwMApAQCAtMSwxMSArMSwyMiBAQAogI2lmbmRlZiBf
X0FTTV9NQUNIX1VOQ09NUFJFU1NfSAogI2RlZmluZSBfX0FTTV9NQUNIX1VOQ09NUFJFU1NfSAog
CisjaW5jbHVkZSA8bGludXgvaW8uaD4KKworI2RlZmluZSBTQ0lGMAkweGU2YzQwMDAwCisjZGVm
aW5lIFNDRlNSCTB4MTQKKyNkZWZpbmUgU0NGVERSCTB4MjAKKyNkZWZpbmUgRlNSX1RFTkQJKDE8
PDYpCisKIC8qCiAgKiBUaGlzIGRvZXMgbm90IGFwcGVuZCBhIG5ld2xpbmUKICAqLwogc3RhdGlj
IHZvaWQgcHV0YyhpbnQgYykKIHsKKwl3aGlsZSghKF9fcmF3X3JlYWR3KFNDSUYwICsgU0NGU1Ip
ICYgRlNSX1RFTkQpKQorCQk7CisJX19yYXdfd3JpdGViKGMsIFNDSUYwICsgU0NGVERSKTsKKwlf
X3Jhd193cml0ZXcoX19yYXdfcmVhZHcoU0NJRjAgKyBTQ0ZTUikgJiB+RlNSX1RFTkQsIFNDSUYw
ICsgU0NGU1IpOwogfQogCiBzdGF0aWMgaW5saW5lIHZvaWQgZmx1c2godm9pZCkK
--001a11c2432ae8e03804e2dfca2c
Content-Type: application/octet-stream; 
	name="linux-3.12-pre-arm-shmobile-smp-mpidr-scu-dbg-20130729.patch"
Content-Disposition: attachment; 
	filename="linux-3.12-pre-arm-shmobile-smp-mpidr-scu-dbg-20130729.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hjts46jk2

RnJvbTogTWFnbnVzIERhbW0gPGRhbW1Ab3BlbnNvdXJjZS5zZT4KClNpZ25lZC1vZmYtYnk6IE1h
Z251cyBEYW1tIDxkYW1tQG9wZW5zb3VyY2Uuc2U+Ci0tLQoKIGFyY2gvYXJtL21hY2gtc2htb2Jp
bGUvaGVhZHNtcC5TIHwgICAxMCArKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKQoKLS0tIDAwMDkvYXJjaC9hcm0vbWFjaC1zaG1vYmlsZS9oZWFkc21wLlMKKysrIHdv
cmsvYXJjaC9hcm0vbWFjaC1zaG1vYmlsZS9oZWFkc21wLlMJMjAxMy0wNy0yOSAxODozNDowMS4w
MDAwMDAwMDAgKzA5MDAKQEAgLTQ0LDYgKzQ0LDEwIEBAIHNobW9iaWxlX2Jvb3RfYXJnOgogICov
CiAKIEVOVFJZKHNobW9iaWxlX3NtcF9ib290KQorCWxkcglyMTEsID0weGU2YzgwMDAwCisJbW92
CXIxMiwgIydAJworCXN0cmIgICAgcjEyLCBbcjExLCAjMHgyMF0KKwkKIAltcmMJcDE1LCAwLCBy
MCwgYzAsIGMwLCA1CQlAIHIwID0gTVBJRFIKIAltb3YJcjEsICMwCQkJCUAgcjEgPSBQZXItQ1BV
IG9mZnNldAogCWFkcglyNSwgMWYKQEAgLTczLDcgKzc3LDEzIEBAIHNobW9iaWxlX3NtcF9ib290
X2ZvdW5kOgogRU5EUFJPQyhzaG1vYmlsZV9zbXBfYm9vdCkKIAogRU5UUlkoc2htb2JpbGVfc21w
X3Jlc2V0KQorCWxkcglyMTEsID0weGU2YzgwMDAwCisJbW92CXIxMiwgIydXJworCXN0cmIgICAg
cjEyLCBbcjExLCAjMHgyMF0KIAl3ZmkKKwlsZHIJcjExLCA9MHhlNmM4MDAwMAorCW1vdglyMTIs
ICMnIScKKwlzdHJiICAgIHIxMiwgW3IxMSwgIzB4MjBdCiAJYglzaG1vYmlsZV9zbXBfYm9vdAog
RU5EUFJPQyhzaG1vYmlsZV9zbXBfcmVzZXQpCiAK
--001a11c2432ae8e03804e2dfca2c--
