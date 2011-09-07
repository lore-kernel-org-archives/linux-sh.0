From: "Koul, Vinod" <vinod.koul@intel.com>
Date: Wed, 07 Sep 2011 21:49:53 +0000
Subject: Re: [PATCH] serial: sh-sci: don't filter on DMA device, use only
Message-Id: <438BB0150E931F4B9CE701519A4463010871804A4F@bgsmsx502.gar.corp.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1106241354060.6014@axis700.grange>
 <1308916071.1536.4.camel@vkoul-udesk3> <20110829080047.GJ31809@linux-sh.org>
 <CANqRtoRn-Csu+Rns6dn6=cJmRqbZfLKXA9brs8Ug9rFvGRn78w@mail.gmail.com>
 <1314618931.1606.114.camel@vkoul-udesk3>
 <Pine.LNX.4.64.1108300931220.19151@axis700.grange>
 <1314698522.1606.164.camel@vkoul-udesk3>
 <Pine.LNX.4.64.1108301317280.19151@axis700.grange>
 <1314703426.1606.167.camel@vkoul-udesk3>
 <Pine.LNX.4.64.1108301332190.19151@axis700.grange>
 <Pine.LNX.4.64.1109051002400.1112@axis700.grange>
 <1315228408.26251.75.camel@vkoul-udesk3>
 <Pine.LNX.4.64.1109051532220.1112@axis700.grange>
 <1315233788.26251.163.camel@vkoul-udesk3>
 <Pine.LNX.4.64.1109051700030.1112@axis700.grange>
 <1315235335.26251.194.camel@vkoul-udesk3>
 <Pine.LNX.4.64.1109051716530.1112@axis700.grange>
 <438BB0150E931F4B9CE701519A4463010871804A4B@bgsmsx502.gar.corp.intel.com>
 <alpine.DEB.2.00.1109072048310.30407@axis700.grange>
In-Reply-To: <alpine.DEB.2.00.1109072048310.30407@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1254"
Content-Transfer-Encoding: base64
To: "g.liakhovetski@gmx.de" <g.liakhovetski@gmx.de>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "lethal@linux-sh.org" <lethal@linux-sh.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "damm@opensource.se" <damm@opensource.se>

T24gV2VkLCAyMDExLTA5LTA3IGF0IDIyOjAxICswMjAwLCBHdWVubmFkaSBMaWFraG92ZXRza2kg
d3JvdGU6Cj4gT24gVGh1LCA4IFNlcCAyMDExLCBLb3VsLCBWaW5vZCB3cm90ZToKPiBZb3UncmUg
c2VyaW91c2x5IHN1Z2dlc3RpbmcgdG8gZXhwb3J0IGFuZCB1c2UgYW4gYWRkaXRpb25hbCBzaGRt
YSBwcml2YXRlIAo+IGZ1bmN0aW9uLCBieXBhc3NpbmcgdGhlIGRtYWVuZ2luZSBBUEk/Li4uIFRo
YXQgcmVhbGx5IGRvZXNuJ3Qgc291bmQgbGlrZSBhIAo+IGdvb2QgaWRlYSB0byBtZSwgc29ycnku
IEhvdyBhYm91dCB1c2luZyAuZGV2aWNlX2NvbnRyb2woRE1BX1NMQVZFX0NPTkZJRykgCj4gZnJv
bSB0aGUgZmlsdGVyIGZ1bmN0aW9uIGRpcmVjdGx5IHRvIHZlcmlmeSBjaGFubmVsIHN1aXRhYmls
aXR5PwpZZXMgc2VlIHN0ZWRtYTQwLCBjb2g5MDEzOCBkcml2ZXJzCi5kZXZpY2VfY29udHJvbCBp
cyBub3QgcmlnaHQgcGxhY2UgYXMgY2hhbm5lbCBpcyBhbHJlYWR5IGFsbG9jYXRlZC4KCllvdSBh
cmUgYmFzaWNhbGx5IG1vdmluZyBmaWx0ZXIgZm4gZnJvbSBhbGwgY2xpZW50cyB0byBkbWFjIGRy
aXZlci4KCj4gCj4gPiBJIGNhbnQgYWdyZWUgdG8gdGhlIHdob2xlIHBvaW50IG9mIGZpbHRlcmlu
ZyBpbiBhbGxvYwo+ID4gCj4gPiBPbmUgY2hhbm5lbCBpcyBhbGxvY2F0ZWQsIHdlIHNob3VsZCBf
bm90XyBkbyBhbnkgZnVydGhlciBmaWx0ZXJpbmcKPiAKPiBTb3JyeSwgSSBkbyBub3QgdW5kZXJz
dGFuZCB0aGlzIGFyZ3VtZW50YXRpb24uIEZpbHRlcmluZyBhbmQgcmVzb3VyY2UgCj4gYWxsb2Nh
dGlvbiBhcmUgcGFydHMgb2YgdGhlIGNoYW5uZWwtYWNxdWlzaXRpb24gcHJvY2VzcywgZWl0aGVy
IG9mIHRoZW0gCj4gY2FuIGZhaWwsIGluIHdoaWNoIGNhc2UgdGhlIGNoYW5uZWwgcmVtYWlucyBm
cmVlIGZvciBmdXR1cmUgcmVxdWVzdHMuCkRNQSBkcml2ZXJzIHNldCBjYXBzIGZvciBlYWNoIGNo
YW5uZWwKQ2xpZW50IHJlcXVlc3RzIGEgY2hhbm5lbCBhbmQgZG1hZW5naW5lIG1hdGNoZXMgY2hh
bm5lbCBiYXNlZCBvbiBjYXBzCmFuZCBmaWxlciBmdW5jdGlvbiBpcyBjYWxsZWQgc28gdGhhdCBh
ZGRpdGlvbmFsIGZpbHRlcmluZyBjYW4gdGFrZQpwbGFjZS4KQW5kIC5hbGxvY19jaGFuX3Jlc291
cmNlcyBpcyBzdXBwb3NlZCB0byBhbGxvY2F0ZSB0aGUgY2hhbm5lbCByZXNvdXJjZQphbmQgbm90
IGRvIGFueXRoaW5nIGVsc2UuCgotLQp+Vmlub2QKCv/06Lp7Lm7HK4m3n66JrYYrJYrL/7Hp3bYX
pYp3/7p7Lm7HK4m3pYp7sf7I/4p7YXm6HcqH2pnrLGoHraJmo6K3aJqP74Hq/5Hq53pf6K4DKK3p
mo6K3aJqIp36GrYbbaf//74Hq/5Hq53p/6K4P5mo6K3aJqP4p36P4Qo=
