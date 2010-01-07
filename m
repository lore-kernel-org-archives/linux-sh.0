From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 Jan 2010 08:44:14 +0000
Subject: Re: [PATCH] MMC: hardware abstraction for CNF area
Message-Id: <aec7e5c31001070044n73b7b0bcw96e6c45885ce7691@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100105050914.32264.762.sendpatchset@rxone.opensource.se>
	 <20100106002158.GM4274@sortiz.org>
	 <aec7e5c31001052057u68deaab2y1d63a2e881ef94a3@mail.gmail.com>
	 <20100106195339.GD23473@sortiz.org>
In-Reply-To: <20100106195339.GD23473@sortiz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, ian@mnementh.co.uk, linux-sh@vger.kernel.org

Hi Samuel,

On Thu, Jan 7, 2010 at 4:53 AM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> I applied the resulting patch to my tree, and will leave it there for at =
least
> a couple days so that linux-next can pick it up.
> Meanwhile, I'd really appreciate if Ian could make sure it works for him =
as
> well. Ian, this is the patch I'm talking about:
>
> http://git.kernel.org/?p=3Dlinux/kernel/git/sameo/mfd-2.6.git;a=3Dcommit;=
h=B3df6513659704ece28da3b80cc36c2a8de315ce

Thanks a lot for your help. I took the patch pointed out above and
applied it on top of latest linux-2.6 git and my kfr2r09 platform now
compiles and works as expected.

Cheers,

/ magnus
