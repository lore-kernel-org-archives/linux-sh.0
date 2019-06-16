From: Rob Landley <rob@landley.net>
Date: Sun, 16 Jun 2019 09:38:59 +0000
Subject: Re: Linux SH kernel currently broken on qemu-system
Message-Id: <3152f4e3-123c-ee18-ddac-b4a14ddddfee@landley.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------A8EC5402C0569D24DB249099"
List-Id: <linux-sh.vger.kernel.org>
References: <e7855beb-fbf6-8f67-140f-21820a0fe4af@physik.fu-berlin.de>
In-Reply-To: <e7855beb-fbf6-8f67-140f-21820a0fe4af@physik.fu-berlin.de>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------A8EC5402C0569D24DB249099
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 6/10/19 8:36 AM, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> Booting the Linux SH kernel in qemu-system currently doesn't work, the screen
> just stays black. Previously, the kernel suffered another regression where it
> booted but crashed very early.

I booted 5.1 to a shell prompt when it came out and you're pointing at a commit
from 2017? Sigh, let's see...

Nope, I just built current git -master (commit e01e060fe00d) and it booted just
fine. (Well, the stupid ___slab_alloc.constprop stack dump it's been doing
forever but I've complained about that here before. I get the shell prompt anyway.)

Could you attach your .config? Here's the one I built, and how I'm launching it.

Hmmm... I checked my notes on the sh7760 hardware and the newest kernel I ran on
that (with dma working, memory to memory with dmaengine and the dmatest plumbing
passed) 4.14, which is just older than  your commit. (But I didn't stop moving
the version forward because of a DMA issue, I stopped because jffs2 on the NOR
flash went flaky in a way that took 10 minutes of hammering to reliably
reproduce and was thus a pain to bisect, and we had a ship deadline, so I stayed
with the last stable one which was less than a year old at the time...)

Rob

--------------A8EC5402C0569D24DB249099
Content-Type: application/x-shellscript;
 name="qemu-sh4.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="qemu-sh4.sh"

cWVtdS1zeXN0ZW0tc2g0IC1NIHIyZCAtc2VyaWFsIG51bGwgLXNlcmlhbCBtb246c3RkaW8g
LW5vZ3JhcGhpYyAtbm8tcmVib290IC1tIDI1NiAtYXBwZW5kICJwYW5pYz0xIEhPU1Q9c2g0
IGNvbnNvbGU9dHR5U0MxIG5vaW90cmFwIiAta2VybmVsIHpJbWFnZSAtaW5pdHJkIHNoNC1s
aW51eC1tdXNsLXJvb3QuY3Bpby5neiAiJEAiCg==
--------------A8EC5402C0569D24DB249099
Content-Type: text/plain; charset=UTF-8;
 name="sh4.miniconf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sh4.miniconf"

IyBtYWtlIEFSQ0g9c2ggYWxsbm9jb25maWcgS0NPTkZJR19BTExDT05GSUc9c2g0Lm1pbmlj
b25mCiMgbWFrZSBBUkNIPXNoIC1qICQobnByb2MpCiMgYm9vdCBhcmNoL3NoL2Jvb3Qveklt
YWdlCgoKQ09ORklHX0NQVV9TVUJUWVBFX1NINzc1MVI9eQpDT05GSUdfTU1VPXkKQ09ORklH
X01FTU9SWV9TVEFSVD0weDBjMDAwMDAwCkNPTkZJR19WU1lTQ0FMTD15CkNPTkZJR19TSF9G
UFU9eQpDT05GSUdfU0hfUlRTNzc1MVIyRD15CkNPTkZJR19SVFM3NzUxUjJEX1BMVVM9eQpD
T05GSUdfU0VSSUFMX1NIX1NDST15CkNPTkZJR19TRVJJQUxfU0hfU0NJX0NPTlNPTEU9eQoK
Q09ORklHX1BDST15CkNPTkZJR19ORVRfVkVORE9SX1JFQUxURUs9eQpDT05GSUdfODEzOUNQ
PXkKCkNPTkZJR19QQ0k9eQpDT05GSUdfQkxLX0RFVl9TRD15CkNPTkZJR19BVEE9eQpDT05G
SUdfQVRBX1NGRj15CkNPTkZJR19BVEFfQk1ETUE9eQpDT05GSUdfUEFUQV9QTEFURk9STT15
CgojQ09ORklHX1NQST15CiNDT05GSUdfU1BJX1NIX1NDST15CiNDT05GSUdfTUZEX1NNNTAx
PXkKCiNDT05GSUdfUlRDX0NMQVNTPXkKI0NPTkZJR19SVENfRFJWX1I5NzAxPXkKI0NPTkZJ
R19SVENfRFJWX1NIPXkKI0NPTkZJR19SVENfSENUT1NZUz15CgoKIyBDT05GSUdfRU1CRURE
RUQgaXMgbm90IHNldApDT05GSUdfRUFSTFlfUFJJTlRLPXkKQ09ORklHX0JJTkZNVF9FTEY9
eQpDT05GSUdfQklORk1UX1NDUklQVD15CkNPTkZJR19OT19IWj15CkNPTkZJR19ISUdIX1JF
U19USU1FUlM9eQoKQ09ORklHX0JMS19ERVY9eQpDT05GSUdfQkxLX0RFVl9JTklUUkQ9eQpD
T05GSUdfUkRfR1pJUD15CgpDT05GSUdfQkxLX0RFVl9MT09QPXkKQ09ORklHX0VYVDRfRlM9
eQpDT05GSUdfRVhUNF9VU0VfRk9SX0VYVDI9eQpDT05GSUdfVkZBVF9GUz15CkNPTkZJR19G
QVRfREVGQVVMVF9VVEY4PXkKQ09ORklHX01JU0NfRklMRVNZU1RFTVM9eQpDT05GSUdfU1FV
QVNIRlM9eQpDT05GSUdfU1FVQVNIRlNfWEFUVFI9eQpDT05GSUdfU1FVQVNIRlNfWkxJQj15
CkNPTkZJR19ERVZUTVBGUz15CkNPTkZJR19ERVZUTVBGU19NT1VOVD15CkNPTkZJR19UTVBG
Uz15CkNPTkZJR19UTVBGU19QT1NJWF9BQ0w9eQoKQ09ORklHX05FVD15CkNPTkZJR19QQUNL
RVQ9eQpDT05GSUdfVU5JWD15CkNPTkZJR19JTkVUPXkKQ09ORklHX0lQVjY9eQpDT05GSUdf
TkVUREVWSUNFUz15CiNDT05GSUdfTkVUX0NPUkU9eQojQ09ORklHX05FVENPTlNPTEU9eQpD
T05GSUdfRVRIRVJORVQ9eQoK
--------------A8EC5402C0569D24DB249099--
