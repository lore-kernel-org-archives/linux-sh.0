From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 16 Apr 2009 04:26:40 +0000
Subject: Re: [PATCH 3/6] Add USB support for SH7724
Message-Id: <umyahusu7.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzlej1ubl.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzlej1ubl.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org


Dear Paul

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0xa4d80000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0xa4d800ff,
>
> Is D1FIFO included in this area? Shouldn't end be ..0123?

Now I noticed that SH7724's USB (r8a66597) register mapping=20
is different from other r8a66597.

It mean r8a66597 driver need fix for SH7724.
I will consult with shimoda-san about it

Therefore, please ignore this patch this time.
Sorry.

Best regards
--
Kuninori Morimoto
=20
