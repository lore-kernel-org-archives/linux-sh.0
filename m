From: Simon Horman <horms@verge.net.au>
Date: Thu, 06 Feb 2014 07:00:40 +0000
Subject: Re: [PATCH 03/03] ARM: shmobile: Lager USB0 cable detection workaround
Message-Id: <20140206070037.GF17591@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140129230959.22655.55645.sendpatchset@w520>
 <20140129231029.22655.58864.sendpatchset@w520>
In-Reply-To: <20140129231029.22655.58864.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jan 30, 2014 at 08:10:29AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add Lager board code to check the PWEN GPIO signal and refuse to
> allow probe of the USBHS driver in case of DIP misconfiguration.
> 
> For correct operation Lager DIP switches SW5 and SW6 shall be
> configured in 2-3 position to enable USB Function support.
> 
> If the DIP switch is configured incorrectly then the user can
> simply adjust the hardware and either reboot or use the bind interface
> to try to probe again:
> 
> # echo renesas_usbhs > /sys/bus/platform/drivers/renesas_usbhs/bind
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queue this up.
