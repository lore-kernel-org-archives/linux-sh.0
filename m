From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sat, 12 May 2012 13:37:36 +0000
Subject: Re: [GIT PULL] Urgent fixes (for v3.4 if possible) for Renesas ARM-based platforms
Message-Id: <Pine.LNX.4.64.1205121532190.11826@axis700.grange>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8323329-1077740113-1336829769=:11826"
List-Id: <linux-sh.vger.kernel.org>
References: <201205112025.13478.rjw@sisk.pl>
 <CAOesGMh3g-7oTNBoj2ZWGw+9P1Sf7V89etLb-iZiVoKDEvhO8w@mail.gmail.com>
 <CANqRtoSDN+vYet+9qiNZQq73BdSiqPL3K+95wCbNL29wDvT4EA@mail.gmail.com>
 <CAOesGMieNxya9w=2a0Lv06qbVb2SOtiLTYeWW=kQ9sbkSzbtvg@mail.gmail.com>
 <Pine.LNX.4.64.1205120832290.7233@axis700.grange>
 <CAOesGMigY=S+aQX84VP9MVpNUYrMDLEXMCJU3L-x3uYEYOTkmw@mail.gmail.com>
In-Reply-To: <CAOesGMigY=S+aQX84VP9MVpNUYrMDLEXMCJU3L-x3uYEYOTkmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1077740113-1336829769=:11826
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-ID: <Pine.LNX.4.64.1205121537001.11826@axis700.grange>
Content-Transfer-Encoding: quoted-printable

On Fri, 11 May 2012, Olof Johansson wrote:

> On Fri, May 11, 2012 at 11:37 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On Fri, 11 May 2012, Olof Johansson wrote:
> >
> >> Hej Magnus,
> >>
> >> On Fri, May 11, 2012 at 9:28 PM, Magnus Damm <magnus.damm@gmail.com>=
 wrote:
> >>
> >> >>> =A0git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.=
git fixes
> >> >>
> >> >> No such branch (nor tag).
> >> >
> >> > I believe Rafael will get back to you about that when he gets to h=
is computer.
> >>
> >> Yep, good.
> >>
> >> >>> Guennadi Liakhovetski (2):
> >> >>> =A0 =A0 =A0ARM: mach-shmobile: convert ag5evm to use the generic=
 MMC GPIO hotplug helper
> >> >>> =A0 =A0 =A0ARM: mach-shmobile: convert mackerel to use the gener=
ic MMC GPIO hotplug helper
> >> >>
> >> >> These seem to fix the long-standing build errors on the two platf=
orms,
> >> >> but that's impossible to tell from reading the commit messages (t=
hey
> >> >> are empty). Care to add one describing why they're important to g=
o in?
> >> >
> >> > I only know that a) some boards don't build without these fixes an=
d b)
> >> > they used to build just fine.
> >> >
> >> > Perhaps Guennadi [CC:ed] could be so kind to fill us in with the b=
lanks?
> >>
> >> It was pretty obvious once I tried applying them and building that
> >> they did indeed resolve the build errors. However, the reason I'm
> >> asking for a better description is that when looking at just the pul=
l
> >> request, or even the patch full commit description, it was impossibl=
e
> >> to tell why the patch was urgent as a fix. So, while I am not
> >> questioning that the patch should be included, I'm just requesting t=
o
> >> make sure it's properly described. That's also good for historical
> >> purposes when someone is reading the git logs a year from now, etc.
> >
> > Ok, sorry, I wasn't sure from the previous mail - would you prefer to
> > actually extend their commit messages? As described here
> >
> > http://thread.gmane.org/gmane.linux.kernel.mmc/12744/focus=3D12748
> >
> > These patches are a part of a patch-series, so, when they were submit=
ted
> > in that context, it was pretty obvious how they relate to the rest.
> > However, unfortunately, they are now applied later than the main patc=
hes
> > in that series, so, their purpose has become much less obvious, and t=
heir
> > main feature now seems to be not the conversion of the affected platf=
orms,
> > but fixing the build.
>=20
> Yeah, that seems to be what happened here, so indeed by now the
> commits are a bit out of context.
>=20
> > So, I think, we could use something like this in the
> > patch descriptions:
> >
> > This also fixes modular mmc build on this platform by eliminating the=
 use
> > of an inline function, which calls into the mmc core.
>=20
> Sounds good, with a cut-and-paste of the build error that happens
> without the patch for extra credit.
>=20
> Rafael, can you add the above or something like it to the commit
> messages when you push out the fixes branch?

Let me try to make it a bit easier yet: here are the biuld failures from=20
both platforms:

mackerel:

arch/arm/mach-shmobile/built-in.o: In function `mackerel_sdhi0_gpio_cd':
pfc-sh7372.c:(.text+0x1138): undefined reference to `mmc_detect_change'

ag5evm:

arch/arm/mach-shmobile/built-in.o: In function `ag5evm_sdhi0_gpio_cd':
pfc-sh73a0.c:(.text+0x7c0): undefined reference to `mmc_detect_change'

Also attaching to this email the patches with added patch descriptions an=
d=20
these error-logs.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
--8323329-1077740113-1336829769=:11826
Content-Type: TEXT/X-DIFF; CHARSET=US-ASCII; NAME=0001-ARM-mach-shmobile-convert-mackerel-to-use-the-generi.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.1205121536090.11826@axis700.grange>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=0001-ARM-mach-shmobile-convert-mackerel-to-use-the-generi.patch

RnJvbSAzMjg4OTM0OTQ0ZDNiNjg1ZDUxNzJiNjc4NjZmNTkyNDQ1MWEwNjFh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogR3Vlbm5hZGkgTGlh
a2hvdmV0c2tpIDxnLmxpYWtob3ZldHNraUBnbXguZGU+DQpEYXRlOiBNb24s
IDE2IEFwciAyMDEyIDIzOjA5OjEzICswMjAwDQpTdWJqZWN0OiBbUEFUQ0gg
MS8yXSBBUk06IG1hY2gtc2htb2JpbGU6IGNvbnZlcnQgbWFja2VyZWwgdG8g
dXNlIHRoZSBnZW5lcmljIE1NQyBHUElPIGhvdHBsdWcgaGVscGVyDQoNClRo
aXMgYWxzbyBmaXhlcyB0aGUgZm9sbG93aW5nIG1vZHVsYXIgbW1jIGJ1aWxk
IGZhaWx1cmU6DQoNCmFyY2gvYXJtL21hY2gtc2htb2JpbGUvYnVpbHQtaW4u
bzogSW4gZnVuY3Rpb24gYGFnNWV2bV9zZGhpMF9ncGlvX2NkJzoNCnBmYy1z
aDczYTAuYzooLnRleHQrMHg3YzApOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRv
IGBtbWNfZGV0ZWN0X2NoYW5nZScNCg0Kb24gdGhpcyBwbGF0Zm9ybSBieSBl
bGltaW5hdGluZyB0aGUgdXNlIG9mIGFuIGlubGluZSBmdW5jdGlvbiwgd2hp
Y2ggDQpjYWxscyBpbnRvIHRoZSBtbWMgY29yZS4NCg0KU2lnbmVkLW9mZi1i
eTogR3Vlbm5hZGkgTGlha2hvdmV0c2tpIDxnLmxpYWtob3ZldHNraUBnbXgu
ZGU+DQpUZXN0ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAdmVyZ2UubmV0
LmF1Pg0KQWNrZWQtYnk6IE1hZ251cyBEYW1tIDxkYW1tQG9wZW5zb3VyY2Uu
c2U+DQpTaWduZWQtb2ZmLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmp3QHNp
c2sucGw+DQotLS0NCiBhcmNoL2FybS9tYWNoLXNobW9iaWxlL2JvYXJkLW1h
Y2tlcmVsLmMgfCAgIDIyICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZp
bGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXNobW9iaWxlL2JvYXJk
LW1hY2tlcmVsLmMgYi9hcmNoL2FybS9tYWNoLXNobW9iaWxlL2JvYXJkLW1h
Y2tlcmVsLmMNCmluZGV4IDRlZTU4MDMuLmFhZTJlMjQgMTAwNjQ0DQotLS0g
YS9hcmNoL2FybS9tYWNoLXNobW9iaWxlL2JvYXJkLW1hY2tlcmVsLmMNCisr
KyBiL2FyY2gvYXJtL21hY2gtc2htb2JpbGUvYm9hcmQtbWFja2VyZWwuYw0K
QEAgLTEwMTUsMjEgKzEwMTUsMTIgQEAgc3RhdGljIGludCBzbG90X2NuN19n
ZXRfY2Qoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiB9DQogDQog
LyogU0RISTAgKi8NCi1zdGF0aWMgaXJxcmV0dXJuX3QgbWFja2VyZWxfc2Ro
aTBfZ3Bpb19jZChpbnQgaXJxLCB2b2lkICphcmcpDQotew0KLQlzdHJ1Y3Qg
ZGV2aWNlICpkZXYgPSBhcmc7DQotCXN0cnVjdCBzaF9tb2JpbGVfc2RoaV9p
bmZvICppbmZvID0gZGV2LT5wbGF0Zm9ybV9kYXRhOw0KLQlzdHJ1Y3QgdG1p
b19tbWNfZGF0YSAqcGRhdGEgPSBpbmZvLT5wZGF0YTsNCi0NCi0JdG1pb19t
bWNfY2Rfd2FrZXVwKHBkYXRhKTsNCi0NCi0JcmV0dXJuIElSUV9IQU5ETEVE
Ow0KLX0NCi0NCiBzdGF0aWMgc3RydWN0IHNoX21vYmlsZV9zZGhpX2luZm8g
c2RoaTBfaW5mbyA9IHsNCiAJLmRtYV9zbGF2ZV90eAk9IFNIRE1BX1NMQVZF
X1NESEkwX1RYLA0KIAkuZG1hX3NsYXZlX3J4CT0gU0hETUFfU0xBVkVfU0RI
STBfUlgsDQorCS50bWlvX2ZsYWdzCT0gVE1JT19NTUNfVVNFX0dQSU9fQ0Qs
DQogCS50bWlvX2NhcHMJPSBNTUNfQ0FQX1NEX0hJR0hTUEVFRCB8IE1NQ19D
QVBfU0RJT19JUlEsDQorCS5jZF9ncGlvCT0gR1BJT19QT1JUMTcyLA0KIH07
DQogDQogc3RhdGljIHN0cnVjdCByZXNvdXJjZSBzZGhpMF9yZXNvdXJjZXNb
XSA9IHsNCkBAIC0xMzkwLDcgKzEzODEsNiBAQCBzdGF0aWMgdm9pZCBfX2lu
aXQgbWFja2VyZWxfaW5pdCh2b2lkKQ0KIHsNCiAJdTMyIHNyY3I0Ow0KIAlz
dHJ1Y3QgY2xrICpjbGs7DQotCWludCByZXQ7DQogDQogCS8qIEV4dGVybmFs
IGNsb2NrIHNvdXJjZSAqLw0KIAljbGtfc2V0X3JhdGUoJnNoNzM3Ml9kdl9j
bGtpX2NsaywgMjcwMDAwMDApOw0KQEAgLTE0ODcsNyArMTQ3Nyw2IEBAIHN0
YXRpYyB2b2lkIF9faW5pdCBtYWNrZXJlbF9pbml0KHZvaWQpDQogCWlycV9z
ZXRfaXJxX3R5cGUoSVJRMjEsIElSUV9UWVBFX0xFVkVMX0hJR0gpOw0KIA0K
IAkvKiBlbmFibGUgU0RISTAgKi8NCi0JZ3Bpb19yZXF1ZXN0KEdQSU9fRk5f
U0RISUNEMCwgTlVMTCk7DQogCWdwaW9fcmVxdWVzdChHUElPX0ZOX1NESElX
UDAsIE5VTEwpOw0KIAlncGlvX3JlcXVlc3QoR1BJT19GTl9TREhJQ01EMCwg
TlVMTCk7DQogCWdwaW9fcmVxdWVzdChHUElPX0ZOX1NESElDTEswLCBOVUxM
KTsNCkBAIC0xNDk2LDEzICsxNDg1LDYgQEAgc3RhdGljIHZvaWQgX19pbml0
IG1hY2tlcmVsX2luaXQodm9pZCkNCiAJZ3Bpb19yZXF1ZXN0KEdQSU9fRk5f
U0RISUQwXzEsIE5VTEwpOw0KIAlncGlvX3JlcXVlc3QoR1BJT19GTl9TREhJ
RDBfMCwgTlVMTCk7DQogDQotCXJldCA9IHJlcXVlc3RfaXJxKGV2dDJpcnEo
MHgzMzQwKSwgbWFja2VyZWxfc2RoaTBfZ3Bpb19jZCwNCi0JCQkgIElSUUZf
VFJJR0dFUl9GQUxMSU5HLCAic2RoaTAgY2QiLCAmc2RoaTBfZGV2aWNlLmRl
dik7DQotCWlmICghcmV0KQ0KLQkJc2RoaTBfaW5mby50bWlvX2ZsYWdzIHw9
IFRNSU9fTU1DX0hBU19DT0xEX0NEOw0KLQllbHNlDQotCQlwcl9lcnIoIkNh
bm5vdCBnZXQgSVJRICMlZDogJWRcbiIsIGV2dDJpcnEoMHgzMzQwKSwgcmV0
KTsNCi0NCiAjaWYgIWRlZmluZWQoQ09ORklHX01NQ19TSF9NTUNJRikgJiYg
IWRlZmluZWQoQ09ORklHX01NQ19TSF9NTUNJRl9NT0RVTEUpDQogCS8qIGVu
YWJsZSBTREhJMSAqLw0KIAlncGlvX3JlcXVlc3QoR1BJT19GTl9TREhJQ01E
MSwgTlVMTCk7DQotLSANCjEuNy4yLjUNCg0K

--8323329-1077740113-1336829769=:11826
Content-Type: TEXT/X-DIFF; CHARSET=US-ASCII; NAME=0002-ARM-mach-shmobile-convert-ag5evm-to-use-the-generic-.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.1205121536091.11826@axis700.grange>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=0002-ARM-mach-shmobile-convert-ag5evm-to-use-the-generic-.patch

RnJvbSBmNzc3YmFjMmEwNmFjNGMwOGRlYTZhODE1YTM0MGUwMDBlZTBiZGY2
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogR3Vlbm5hZGkgTGlh
a2hvdmV0c2tpIDxnLmxpYWtob3ZldHNraUBnbXguZGU+DQpEYXRlOiBNb24s
IDE2IEFwciAyMDEyIDIzOjA5OjE5ICswMjAwDQpTdWJqZWN0OiBbUEFUQ0gg
Mi8yXSBBUk06IG1hY2gtc2htb2JpbGU6IGNvbnZlcnQgYWc1ZXZtIHRvIHVz
ZSB0aGUgZ2VuZXJpYyBNTUMgR1BJTyBob3RwbHVnIGhlbHBlcg0KDQpUaGlz
IGFsc28gZml4ZXMgdGhlIGZvbGxvd2luZyBtb2R1bGFyIG1tYyBidWlsZCBm
YWlsdXJlOg0KDQphcmNoL2FybS9tYWNoLXNobW9iaWxlL2J1aWx0LWluLm86
IEluIGZ1bmN0aW9uIGBtYWNrZXJlbF9zZGhpMF9ncGlvX2NkJzoNCnBmYy1z
aDczNzIuYzooLnRleHQrMHgxMTM4KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0
byBgbW1jX2RldGVjdF9jaGFuZ2UnDQoNCm9uIHRoaXMgcGxhdGZvcm0gYnkg
ZWxpbWluYXRpbmcgdGhlIHVzZSBvZiBhbiBpbmxpbmUgZnVuY3Rpb24sIHdo
aWNoIA0KY2FsbHMgaW50byB0aGUgbW1jIGNvcmUuDQoNClNpZ25lZC1vZmYt
Ynk6IEd1ZW5uYWRpIExpYWtob3ZldHNraSA8Zy5saWFraG92ZXRza2lAZ214
LmRlPg0KUmV2aWV3ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAdmVyZ2Uu
bmV0LmF1Pg0KQWNrZWQtYnk6IE1hZ251cyBEYW1tIDxkYW1tQG9wZW5zb3Vy
Y2Uuc2U+DQpTaWduZWQtb2ZmLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmp3
QHNpc2sucGw+DQotLS0NCiBhcmNoL2FybS9tYWNoLXNobW9iaWxlL2JvYXJk
LWFnNWV2bS5jIHwgICAyMiArKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQogMSBm
aWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1zaG1vYmlsZS9ib2Fy
ZC1hZzVldm0uYyBiL2FyY2gvYXJtL21hY2gtc2htb2JpbGUvYm9hcmQtYWc1
ZXZtLmMNCmluZGV4IGNiMjI0YTMuLjA4OTFlYzYgMTAwNjQ0DQotLS0gYS9h
cmNoL2FybS9tYWNoLXNobW9iaWxlL2JvYXJkLWFnNWV2bS5jDQorKysgYi9h
cmNoL2FybS9tYWNoLXNobW9iaWxlL2JvYXJkLWFnNWV2bS5jDQpAQCAtMzY1
LDIzICszNjUsMTMgQEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
bWlwaWRzaTBfZGV2aWNlID0gew0KIH07DQogDQogLyogU0RISTAgKi8NCi1z
dGF0aWMgaXJxcmV0dXJuX3QgYWc1ZXZtX3NkaGkwX2dwaW9fY2QoaW50IGly
cSwgdm9pZCAqYXJnKQ0KLXsNCi0Jc3RydWN0IGRldmljZSAqZGV2ID0gYXJn
Ow0KLQlzdHJ1Y3Qgc2hfbW9iaWxlX3NkaGlfaW5mbyAqaW5mbyA9IGRldi0+
cGxhdGZvcm1fZGF0YTsNCi0Jc3RydWN0IHRtaW9fbW1jX2RhdGEgKnBkYXRh
ID0gaW5mby0+cGRhdGE7DQotDQotCXRtaW9fbW1jX2NkX3dha2V1cChwZGF0
YSk7DQotDQotCXJldHVybiBJUlFfSEFORExFRDsNCi19DQotDQogc3RhdGlj
IHN0cnVjdCBzaF9tb2JpbGVfc2RoaV9pbmZvIHNkaGkwX2luZm8gPSB7DQog
CS5kbWFfc2xhdmVfdHgJPSBTSERNQV9TTEFWRV9TREhJMF9UWCwNCiAJLmRt
YV9zbGF2ZV9yeAk9IFNIRE1BX1NMQVZFX1NESEkwX1JYLA0KLQkudG1pb19m
bGFncwk9IFRNSU9fTU1DX0hBU19JRExFX1dBSVQsDQorCS50bWlvX2ZsYWdz
CT0gVE1JT19NTUNfSEFTX0lETEVfV0FJVCB8IFRNSU9fTU1DX1VTRV9HUElP
X0NELA0KIAkudG1pb19jYXBzCT0gTU1DX0NBUF9TRF9ISUdIU1BFRUQsDQog
CS50bWlvX29jcl9tYXNrCT0gTU1DX1ZERF8yN18yOCB8IE1NQ19WRERfMjhf
MjksDQorCS5jZF9ncGlvCT0gR1BJT19QT1JUMjUxLA0KIH07DQogDQogc3Rh
dGljIHN0cnVjdCByZXNvdXJjZSBzZGhpMF9yZXNvdXJjZXNbXSA9IHsNCkBA
IC01NTcsNyArNTQ3LDYgQEAgc3RhdGljIHZvaWQgX19pbml0IGFnNWV2bV9p
bml0KHZvaWQpDQogCWxjZF9iYWNrbGlnaHRfcmVzZXQoKTsNCiANCiAJLyog
ZW5hYmxlIFNESEkwIG9uIENOMTUgW1NEIEkvRl0gKi8NCi0JZ3Bpb19yZXF1
ZXN0KEdQSU9fRk5fU0RISUNEMCwgTlVMTCk7DQogCWdwaW9fcmVxdWVzdChH
UElPX0ZOX1NESElXUDAsIE5VTEwpOw0KIAlncGlvX3JlcXVlc3QoR1BJT19G
Tl9TREhJQ01EMCwgTlVMTCk7DQogCWdwaW9fcmVxdWVzdChHUElPX0ZOX1NE
SElDTEswLCBOVUxMKTsNCkBAIC01NjYsMTMgKzU1NSw2IEBAIHN0YXRpYyB2
b2lkIF9faW5pdCBhZzVldm1faW5pdCh2b2lkKQ0KIAlncGlvX3JlcXVlc3Qo
R1BJT19GTl9TREhJRDBfMSwgTlVMTCk7DQogCWdwaW9fcmVxdWVzdChHUElP
X0ZOX1NESElEMF8wLCBOVUxMKTsNCiANCi0JaWYgKCFyZXF1ZXN0X2lycShp
bnRjc19ldnQyaXJxKDB4M2MwKSwgYWc1ZXZtX3NkaGkwX2dwaW9fY2QsDQot
CQkJIElSUUZfVFJJR0dFUl9GQUxMSU5HIHwgSVJRRl9UUklHR0VSX1JJU0lO
RywNCi0JCQkgInNkaGkwIGNkIiwgJnNkaGkwX2RldmljZS5kZXYpKQ0KLQkJ
c2RoaTBfaW5mby50bWlvX2ZsYWdzIHw9IFRNSU9fTU1DX0hBU19DT0xEX0NE
Ow0KLQllbHNlDQotCQlwcl93YXJuKCJVbmFibGUgdG8gc2V0dXAgU0RISTAg
R1BJTyBJUlFcbiIpOw0KLQ0KIAkvKiBlbmFibGUgU0RISTEgb24gQ040IFtX
TEFOIEkvRl0gKi8NCiAJZ3Bpb19yZXF1ZXN0KEdQSU9fRk5fU0RISUNMSzEs
IE5VTEwpOw0KIAlncGlvX3JlcXVlc3QoR1BJT19GTl9TREhJQ01EMV9QVSwg
TlVMTCk7DQotLSANCjEuNy4yLjUNCg0K

--8323329-1077740113-1336829769=:11826--
