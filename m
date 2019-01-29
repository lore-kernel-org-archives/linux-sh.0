From: Chris Brandt <Chris.Brandt@renesas.com>
Date: Tue, 29 Jan 2019 15:02:15 +0000
Subject: RE: [PATCH 3/7] sh_eth: offload RX checksum on R7S72100
Message-Id: <TY1PR01MB15628BF7F66DCCE3CD1827D58A970@TY1PR01MB1562.jpnprd01.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <fc43bfa2-4312-b52b-a749-e3e43e242a95@cogentembedded.com>
 <0476beba-ea1f-7675-aa08-573b74e84f4e@cogentembedded.com>
 <20190128122053.vb5ifhf34zbnuclp@verge.net.au>
 <916ed105-d499-4ca1-8418-4743b5a7a60d@cogentembedded.com>
 <20190129080004.blc3jrt5y2j7dauo@verge.net.au>
 <e5b05616-d9b3-3c0a-189b-4fc02190c8a5@cogentembedded.com>
In-Reply-To: <e5b05616-d9b3-3c0a-189b-4fc02190c8a5@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

T24gVHVlc2RheSwgSmFudWFyeSAyOSwgMjAxOSwgU2VyZ2VpIFNodHlseW92IHdyb3RlOg0KPiBP
biAwMS8yOS8yMDE5IDExOjAwIEFNLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+ID4gQXMgeW91IG1h
eSBoYXZlIGd1ZXNzZWQgdGhlIGltcGxpY2F0aW9uIG9mIG15IHF1ZXN0aW9uIGlzIHRoYXQNCj4g
PiBJTUhPIGl0IHdvdWxkIGJlIGJlc3Qgb25seSB0byBhZGQgdGhpcyBmZWF0dXJlIHRvIFNvQ3Mg
d2hlcmUNCj4gPiBpdCBoYXMgYmVlbiB0ZXN0ZWQuDQo+IA0KPiAgICBZb3UgZG9uJ3QgdHJ1c3Qg
dGhlIG1hbnVhbHM/IDotKQ0KPiANCj4gTUJSLCBTZXJnZWkNCg0KSG93IHdlcmUgeW91IHRlc3Rp
bmcgdGhpcyBmZWF0dXJlIHdpdGggdGhlIFI4QTc3OTgwPw0KDQpDaHJpcw0KDQo
