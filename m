From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 04 May 2012 16:28:19 +0000
Subject: Re: [PATCH 00/06] serial8250: DLL/DLM rework, Emma Mobile UART driver
Message-Id: <201205041628.20024.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20120502124642.30480.41373.sendpatchset@w520>
In-Reply-To: <20120502124642.30480.41373.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-serial@vger.kernel.org, horms@verge.net.au, linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, paul.gortmaker@windriver.com, lethal@linux-sh.org, olof@lixom.net, dan.j.williams@intel.com, alan@linux.intel.com

On Wednesday 02 May 2012, Magnus Damm wrote:
> Note that there is no DT support included at this point,
> but it boils down to a 10 line change. The boot loader on
> my board does not do DT so I'd like to use kexec for DT
> development (as usual), but to use kexec I first need to
> get a non-DT kernel working. Which is basically this. =)

As a follow-up on this, based on my comments to your emma platform
code, I think it would be easy enough to just use the appended
dtb support that we have, which allows you to boot a DT-enabled
kernel with a legacy boot loader.

	Arnd

