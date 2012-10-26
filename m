From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 26 Oct 2012 10:16:12 +0000
Subject: RE: mainlining tps80031
Message-Id: <Pine.LNX.4.64.1210261212170.20835@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laxman

On Fri, 26 Oct 2012, Laxman Dewangan wrote:

> We have also plan for upstreaming this driver but lack of time, we were 
> not able to do this.
> We are targeting this for k3.8.

This is very good to hear! 3.8 would also be my goal. In fact U have 
already merged your relevant patches on top of current next, at least they 
compile. Would you mind if I post the resulting source as several patches 
- for the beginning 1 for the MFD and 1 for the regulator drivers. I would 
certainly preserve the original authorship and Sob's from all contributors 
would be appropriate. Would this be ok?

Thanks
Guennadi

> -----Original Message-----
> From: Guennadi Liakhovetski [mailto:g.liakhovetski@gmx.de] 
> Sent: Friday, October 26, 2012 12:13 PM
> To: Laxman Dewangan
> Cc: Venu Byravarasu; android-porting@googlegroups.com
> Subject: mainlining tps80031
> 
> Hi Laxman, all
> 
> I have been tasked with mainlining a tps80031 driver and your driver, 
> available in
> 
> https://android.googlesource.com/kernel/tegra	android-tegra3-grouper-3.1-jb-fr2
> 
> seems to be a good starting point. Is anyone already working on mainlining 
> it or are there any plans at all? Would it be ok if I do that, could you 
> or someone else at Nvidia review and re-test my patches and provide their 
> Signed-off-by tags to support the original patch authorship?
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
