From: Samuel Ortiz <sameo@linux.intel.com>
Date: Wed, 06 Jan 2010 19:53:40 +0000
Subject: Re: [PATCH] MMC: hardware abstraction for CNF area
Message-Id: <20100106195339.GD23473@sortiz.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100105050914.32264.762.sendpatchset@rxone.opensource.se>
 <20100106002158.GM4274@sortiz.org>
 <aec7e5c31001052057u68deaab2y1d63a2e881ef94a3@mail.gmail.com>
In-Reply-To: <aec7e5c31001052057u68deaab2y1d63a2e881ef94a3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, ian@mnementh.co.uk, linux-sh@vger.kernel.org

Hi Magnus,

On Wed, Jan 06, 2010 at 01:57:09PM +0900, Magnus Damm wrote:
>=20
> Thanks a lot for your help. I'll submit a patch on top of this one
> with fixes. Feel free to apply it on top or roll it in.
I rolled it into Ian's patch, and added an additional fix for one of the
toshiba mfd driver.
I applied the resulting patch to my tree, and will leave it there for at le=
ast
a couple days so that linux-next can pick it up.
Meanwhile, I'd really appreciate if Ian could make sure it works for him as
well. Ian, this is the patch I'm talking about:

http://git.kernel.org/?p=3Dlinux/kernel/git/sameo/mfd-2.6.git;a=3Dcommit;h=
=B3df6513659704ece28da3b80cc36c2a8de315ce

Cheers,
Samuel.


> Cheers,
>=20
> / magnus

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
