From: Chris Ball <cjb@laptop.org>
Date: Sun, 26 May 2013 17:56:33 +0000
Subject: Re: [PATCH 0/3] mmc: sdhi / tmio: add DT DMA
Message-Id: <87bo7xlj5a.fsf@octavius.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1366991239-22602-1-git-send-email-g.liakhovetski@gmx.de>
	<87fvx9ljak.fsf@octavius.laptop.org>
In-Reply-To: <87fvx9ljak.fsf@octavius.laptop.org> (Chris Ball's message of
	"Sun, 26 May 2013 13:53:23 -0400")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Hi,

On Sun, May 26 2013, Chris Ball wrote:
> On Fri, Apr 26 2013, Guennadi Liakhovetski wrote:
>> These 3 patches add Device Tree DMA support to the TMIO MMC driver, when 
>> used on SDHI platforms.
>>
>> Samuel: these patches touch an mfd header file lightly, I think, it's 
>> better just to get your ack than to make a separate patch via your tree.
>>
>> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>>
>> Guennadi Liakhovetski (3):
>>   mmc: sdhi/tmio: make DMA filter implementation specific
>>   mmc: sdhi/tmio: switch to using dmaengine_slave_config()
>>   mmc: sdhi/tmio: add DT DMA support
>
> Looks like this doesn't apply to mmc-next -- if you could prepare
> current pull requests for 3.10 and 3.11 for me, I'd really appreciate
> it.  Thanks!

Sorry, I'm wrong about this patchset not applying -- I've applied it
to mmc-next for 3.11 now.  The pull requests for other patches might
still be a good idea anyway, though.  :-)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
