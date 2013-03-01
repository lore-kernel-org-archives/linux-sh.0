From: Simon Horman <horms@verge.net.au>
Date: Fri, 01 Mar 2013 09:42:05 +0000
Subject: Re: [PATCH v3 3/3] ARM: mach-shmobile: r8a7740: Setup the serial devices using DT
Message-Id: <20130301094205.GG27938@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1361898208-6683-1-git-send-email-hechtb+renesas@gmail.com>
 <1361898208-6683-3-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1361898208-6683-3-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org

On Tue, Feb 26, 2013 at 11:03:28AM -0600, Bastian Hecht wrote:
> We can now use the Device Tree for bringing up our serial devices. We
> need to add an alternative early_devices list in setup-r8a7740 without
> the serial devices and move them into the Armadillo-reference .dts config file.

Hi Bastian,

could you please refresh this patch on top of the current topic/intc-of.
In particular, it conflicts with changes made by:

ARM: shmobile: r8a7740: Do not use early devices with DT reference
