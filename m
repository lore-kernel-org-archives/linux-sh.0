From: Katsuya MATSUBARA <matsu@igel.co.jp>
Date: Tue, 23 Apr 2013 05:45:49 +0000
Subject: Re: [PATCH v2 1/4] V4L2: soc_camera: Renesas R-Car VIN driver
Message-Id: <20130423.144549.45370868.matsu@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <201304200231.31802.sergei.shtylyov@cogentembedded.com>
	<20130423.120834.239982915.matsu@igel.co.jp>
	<5176104B.7000401@cogentembedded.com>
In-Reply-To: <5176104B.7000401@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sergei.shtylyov@cogentembedded.com
Cc: g.liakhovetski@gmx.de, mchehab@redhat.com, linux-media@vger.kernel.org, magnus.damm@gmail.com, linux-sh@vger.kernel.org, phil.edworthy@renesas.com, vladimir.barinov@cogentembedded.com, mukawa@igel.co.jp


 Hi,

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 23 Apr 2013 08:38:35 +0400

> On 04/23/2013 07:08 AM, Katsuya MATSUBARA wrote:
>=20
>>> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>>
(snip)
>>> +/* Register offsets for R-=F3ar VIN */
>> Are you using a 2-byte character in the string 'R-Car'?
>=20
>    Hm, you have surprised me: indeed KMail chose UTF-8 and, even worse,
> quoted-printable encoding. I played some with the settings, let's see
> what
> will it do...
>=20
> [...]
>=20
>>
>>> +
>>> +/* Register bit fields for R-=F3ar VIN */
>> s/R-=F3ar/R-Car/
>=20
>     Sorry, I see no difference. :-)

Replacing the UTF-8 character 'C'(0xd0 0xa1) in the two above
comments in your patch with ASCII character 'C' (0x43) can
solve the encoding issue.

00000cf0  2b 2f 2a 20 52 65 67 69  73 74 65 72 20 6f 66 66  |+/* Register o=
ff|
00000d00  73 65 74 73 20 66 6f 72  20 52 2d d0 a1 61 72 20  |sets for R-..a=
r |
                                            ^^^^^
000012a0  74 65 72 20 2a 2f 0a 2b  0a 2b 2f 2a 20 52 65 67  |ter */.+.+/* R=
eg|
000012b0  69 73 74 65 72 20 62 69  74 20 66 69 65 6c 64 73  |ister bit fiel=
ds|
000012c0  20 66 6f 72 20 52 2d d0  a1 61 72 20 56 49 4e 20  | for R-..ar VI=
N |
                               ^^^^^^
Thanks,
---
Katsuya Matsubara / IGEL Co., Ltd
matsu@igel.co.jp
