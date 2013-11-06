From: Bastian Hecht <hechtb@gmail.com>
Date: Wed, 06 Nov 2013 15:26:02 +0000
Subject: Re: [PATCH 4/5] serial: sh-sci: Add OF support
Message-Id: <CABYn4syy10bZ+z=Fn+KK_m14GyMLPMrBGFMHntKWW6p4=VH9FQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1383042599-25151-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<CABYn4sxC02bX7XqN8yQ-gYgZEdaHAUohOjyL3pjGYXK9kd8WXg@mail.gmail.com>
	<1449714.Sp0o1f9lVb@avalon>
In-Reply-To: <1449714.Sp0o1f9lVb@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

>> given that we only support ARM based ports and we hope the regtype and
>> brr_algo won't deviate a lot from the given generic settings for new chips
>
> Hopefully :-) I'm trying to simplify the baud rate algorithms mess, I should
> be able to post patches soon, but I need to test them on hardware first. Would
> you have a sh7780, sh7785 or sh7786 board by any chance ?

No never touched these unfortunately.

Cheers,

 Bastian
