From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 04 Feb 2015 14:50:26 +0000
Subject: Re: [PATCH 0/2] Add VSP1 devices to DT for r8a7790 and r8a7791
Message-Id: <2453020.jgrBrSjfDW@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

On Tuesday 03 February 2015 09:41:23 Devendra Talegaonkar wrote:
> Hi Laurent,
> 
> This is altogether a different question & not sure if I am doing sense or
> not.
> 
> I am trying to access drmModeSetCrtc and drmModeSetPlane from 2 different
> processes. The scenario is:
> 
> * Process1 is creating frame buffer for CRTc & for specific plane & by
> calling drmModeSetPlane, overlaying on CRTc
> 
> * Process2 is also creating frame buffer for different plane & trying to
> overlay it on CRTc
>
> In the Process2 drmModeSetPlane is not showing anything on display.
> 
> Is it the desired behavior or I am doing something wrong here.

That doesn't sound like the desired behaviour to me. Note that KMS expects a 
single process to control mode setting. You can get around that by dropping 
master privileges in the first process after setting the CRTC mode, but you 
can't get master privileges back once you've dropped them (short of dropping 
master in the second process and then closing/reopening the device in the 
first process of course).

-- 
Regards,

Laurent Pinchart

