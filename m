From: Chris Brandt <Chris.Brandt@renesas.com>
Date: Wed, 08 Aug 2018 20:46:37 +0000
Subject: RE: [PATCH/RFC 0/4] sh-sci : Do not derive regshift from regsize
Message-Id: <TY1PR01MB1562E090B9BE06CC2EE5BDD58A260@TY1PR01MB1562.jpnprd01.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180806140755.24087-1-geert+renesas@glider.be>
 <CAMuHMdX1bbOhtpVrjNC5hAAR8y_+f9eM1STigxMhWUZEdkJzZg@mail.gmail.com>
In-Reply-To: <CAMuHMdX1bbOhtpVrjNC5hAAR8y_+f9eM1STigxMhWUZEdkJzZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "uli@fpond.eu" <uli@fpond.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>

SGkgR2VlcnQsDQoNCkp1c3QgRllJLi4uDQoNCk9uIFdlZG5lc2RheSwgQXVndXN0IDA4LCAyMDE4
LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQo+ICAgNC4gRHJvcCAicmVuZXNhcyxzY2lmIiBm
cm9tIHRoZSBjb21wYXRpYmxlIHZhbHVlIGluIHRoZSAobm90IHlldA0KPiAgICAgIHN1Ym1pdHRl
ZCkgcjdzOTIxMC5kdHNpICh0aGlzIG1heSBoYXZlIHRvIGJlIGNsYXJpZmllZCBpbiB0aGUgRFQN
Cj4gICAgICBiaW5kaW5ncywgYWx0aG91Z2ggdGhleSBhbHJlYWR5IHNheSAicmVuZXNhcyxzY2lm
IiBpcyBvbmx5IG1lYW50IGZvcg0KPiAgICAgIHBvcnRzIGNvbXBhdGlibGUgd2l0aCB0aGUgZ2Vu
ZXJpYyB2ZXJzaW9uLCB3aGF0ZXZlciB0aGF0IG1lYW5zIDstKSwNCg0KSnVzdCBhcyB5b3Ugd291
bGQgZXhwZWN0LCBpZiBJIGRyb3AgInJlbmVzYXMsc2NpZiIgZnJvbSByN3M5MjEwLmR0c2ksIA0K
dGhlbiBlYXJseWNvbiB3b3JrcyB3aXRoIHlvdXIgUkZDIHBhdGNoZXMgc2luY2Ugbm93IHRoZXJl
IGlzIG9ubHkgb25lDQpjb21wYXRpYmxlIGl0IGNhbiBwb3NzaWJseSBtYXRjaCBhZ2FpbnN0Lg0K
DQoNCkNocmlzDQo