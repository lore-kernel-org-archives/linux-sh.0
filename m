From: Laxman Dewangan <ldewangan@nvidia.com>
Date: Fri, 26 Oct 2012 10:46:49 +0000
Subject: Re: mainlining tps80031
Message-Id: <508A6749.30606@nvidia.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1210261212170.20835@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1210261212170.20835@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday 26 October 2012 04:03 PM, Guennadi Liakhovetski wrote:
> On Fri, 26 Oct 2012, Laxman Dewangan wrote:
>
>> On Friday 26 October 2012 03:46 PM, Guennadi Liakhovetski wrote:
>>> Hi Laxman
>>>
>>> On Fri, 26 Oct 2012, Laxman Dewangan wrote:
>>>
>>>> We have also plan for upstreaming this driver but lack of time, we were
>>>> not able to do this.
>>>> We are targeting this for k3.8.
>>> This is very good to hear! 3.8 would also be my goal. In fact U have
>>> already merged your relevant patches on top of current next, at least they
>>> compile. Would you mind if I post the resulting source as several patches
>>> - for the beginning 1 for the MFD and 1 for the regulator drivers. I would
>>> certainly preserve the original authorship and Sob's from all contributors
>>> would be appropriate. Would this be ok?
>>>
>> I am fine with this. Do you have our k3.4 code with you? Still need some
>> cleanups on these before sending to mainline.
> For my port I cloned
>
> https://android.googlesource.com/kernel/tegra	android-tegra3-grouper-3.1-jb-fr2
>
> Is a newer version available somewhere?
>
You need to clone for K3.4. We have changed the driver lots in k3.4 like 
converting to regmap.


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
