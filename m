From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 09 Feb 2015 08:59:46 +0000
Subject: Re: [PATCH 0/2] Add VSP1 devices to DT for r8a7790 and r8a7791
Message-Id: <3008098.CoKsWlASo9@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Devendra,

On Thursday 05 February 2015 00:28:26 Devendra Talegaonkar wrote:
> Thanks Laurent for your reply.
> The problem we are facing is, we are planning to assign overlay planes to
> different modules in the system (processes) & depending on the system
> context we want to decide which overlay plane needs to bring forward and
> which overlay plane needs to hide. As you suggested in the previous mail, 
> handling XXSetPlane API would not be a desired option.
> 
> Can you please suggest any suitable mechanism for the same?

This is something usually handled by the display server, i.e. X11 or Wayland.

-- 
Regards,

Laurent Pinchart

