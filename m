From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Tue, 21 Jun 2016 05:30:40 +0000
Subject: Re: [PATCH] devpts: remove DEVPTS_MULTIPLE_INSTANCES from all configs
Message-Id: <C2D7FE5348E1B147BCA15975FBA230750106944A83@us01wembx1.internal.synopsys.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160620091258.11233-1-00moses.alexander00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 20 June 2016 02:44 PM, Alexandru Moise wrote:
> As each mount of devpts is now an independent filesystem,
> the DEVPTS_MULTIPLE_INSTANCES config option no longer exists.
> So remove it.
>
> Signed-off-by: Alexandru Moise <00moses.alexander00@gmail.com>

For arch/arc

Acked-by: Vineet Gupta <vgupta@synopsys.com>
