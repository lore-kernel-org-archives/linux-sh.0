From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 07 Jan 2013 13:33:56 +0000
Subject: Re: [PATCH 01/17] ARM: shmobile: fix memory size for kota2_defconfig
Message-Id: <201301071333.56733.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1349195816-2225-1-git-send-email-arnd@arndb.de> <CAOesGMg6afPjBc82FEOwzwn-nBAFPY7K_udJRJO1bBrtCk3Yvg@mail.gmail.com> <20130107015929.GA27346@verge.net.au>
In-Reply-To: <20130107015929.GA27346@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@infradead.org, arm@kernel.org, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Monday 07 January 2013, Simon Horman wrote:
> I have my kota2 board up and running now and I believe that
> the correct value is 0x1e000000. I will apply a patch to my
> defconfigs branch accordingly.

Ok, thanks!

Should we mark that patch for stable backports?

	Arnd
