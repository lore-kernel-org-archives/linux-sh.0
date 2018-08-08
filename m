From: Chris Brandt <Chris.Brandt@renesas.com>
Date: Wed, 08 Aug 2018 10:39:11 +0000
Subject: RE: [PATCH/RFC 4/4] sh-sci: Derive regshift value from DT compatible value
Message-Id: <TY1PR01MB1562EEC8C0F3AB19370AC6F98A260@TY1PR01MB1562.jpnprd01.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180806140755.24087-1-geert+renesas@glider.be>
 <20180806140755.24087-5-geert+renesas@glider.be>
 <TY1PR01MB15621F645BA5AA48C6060F0D8A200@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdWfsdbmGUQPk4O=9jyPZ_tUEytO5z2XE6-TnagJ3taPVA@mail.gmail.com>
 <TY1PR01MB1562F2D2FD1BF47A80B044028A270@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdWgJrPRh8TRTrEjWsaRAhEQX0T7M5eBGP_z3Ft=T6FfDg@mail.gmail.com>
 <TY1PR01MB1562BACED660584300228AA08A260@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdU4WW_Yx7P1rJjUNSaDXXcSGDAyqap1Gm9sVcDRgL09dg@mail.gmail.com>
In-Reply-To: <CAMuHMdU4WW_Yx7P1rJjUNSaDXXcSGDAyqap1Gm9sVcDRgL09dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "uli@fpond.eu" <uli@fpond.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>

SGkgR2VlcnQsDQoNCk9uIFdlZG5lc2RheSwgQXVndXN0IDA4LCAyMDE4LCBHZWVydCBVeXR0ZXJo
b2V2ZW4gd3JvdGU6DQo+IEJUVywgSSBndWVzcyBlYXJseWNvbiBhbHNvIHdvcmtzIG9uIFJaL0Ey
IHdpdGggY3VycmVudCB0dHktbmV4dCBvcg0KPiBsYXRlc3QgcmVuZXNhcy1kcml2ZXJzPw0KDQpJ
IHdhcyB1c2luZyB5b3VyIFJGQyBwYXRjaGVzIG9uIHRvcCBvZiB0aGUgY3VycmVudCByZW5lc2Fz
LWRyaXZlcnMuDQoNCkNocmlzDQo