From: Devendra Talegaonkar <Devendra.Talegaonkar@kpit.com>
Date: Thu, 05 Feb 2015 00:28:26 +0000
Subject: Re: [PATCH 0/2] Add VSP1 devices to DT for r8a7790 and r8a7791
Message-Id: <1423096093300.88011@kpit.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Thanks Laurent for your reply.
The problem we are facing is, we are planning to assign overlay planes to different modules in the system (processes) & depending on the system context we want to decide which overlay plane needs to bring forward and which overlay plane needs to hide. As you suggested in the previous mail,  handling XXSetPlane API would not be a desired option.

Can you please suggest any suitable mechanism for the same?

Thanks & Regards,
Devendra Talegaonkar

________________________________________
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Sent: Wednesday, February 4, 2015 2:50 PM
To: Devendra Talegaonkar
Cc: linux-sh@vger.kernel.org
Subject: Re: [PATCH 0/2] Add VSP1 devices to DT for r8a7790 and r8a7791

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

This message contains information that may be privileged or confidential and is the property of the KPIT Technologies Ltd. It is intended only for the person to whom it is addressed. If you are not the intended recipient, you are not authorized to read, print, retain copy, disseminate, distribute, or use this message or any part thereof. If you receive this message in error, please notify the sender immediately and delete all copies of this message. KPIT Technologies Ltd. does not accept any liability for virus infected mails.
