From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 08 Jan 2013 19:06:32 +0000
Subject: Re: [PATCH 01/17] ARM: shmobile: fix memory size for kota2_defconfig
Message-Id: <201301081906.32685.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1349195816-2225-1-git-send-email-arnd@arndb.de> <201301071333.56733.arnd@arndb.de> <20130108001947.GE16982@verge.net.au>
In-Reply-To: <20130108001947.GE16982@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@infradead.org, arm@kernel.org, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Tuesday 08 January 2013, Simon Horman wrote:
> > 
> > Should we mark that patch for stable backports?
> 
> I don't believe it warrants a stable backport as
> the board appears to function well without the change.

Ok, fair enough. I was thinking of getting rid of the build warning in the older
kernel, but it's probably not worth it if there is no functional impact.

	Arnd
