From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 06 Mar 2014 19:25:23 +0000
Subject: Re: NFS root on Koelsch reference
Message-Id: <5318CBA3.7000906@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdUND0D8rj4K3ZPqx1XqS7czK3PeHfBqTu2WRWQw3Ecj1A@mail.gmail.com>
In-Reply-To: <CAMuHMdUND0D8rj4K3ZPqx1XqS7czK3PeHfBqTu2WRWQw3Ecj1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 06/03/14 19:22, Geert Uytterhoeven wrote:
> Now we have DT support for Ethernet on r8a7791, I struggled a bit to get NFS
> root working on Koelsch reference.
>
> While I still need "[PATCH] ARM: shmobile: compile drivers/sh for
> CONFIG_ARCH_SHMOBILE_MULTI" to make the thermal sensor warning
> go away, this same patch causes a kernel panic when starting userspace from
> NFS root on Koelsch reference:

I will try and see if that patch can be moved along.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
