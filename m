From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Nov 2013 08:59:55 +0000
Subject: Re: [PATCH] ARM: shmobile: Use ->init_late() on Lager
Message-Id: <20131118085953.GF1506@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131113223406.20634.52693.sendpatchset@w520>
In-Reply-To: <20131113223406.20634.52693.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 14, 2013 at 07:34:06AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Hook in shmobile_init_late() on Lager. This enables some PM
> related things like CPUIdle and Suspend-to-RAM.
> 
> With this patch applied it is possible to use Suspend-to-RAM:
> # echo enabled > /sys/class/tty/ttySC6/power/wakeup
> # echo mem > /sys/power/state 
> (wake by sending a character on the serial console)
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I will queue this up.
