From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Feb 2014 04:48:58 +0000
Subject: Re: [PATCH 0/2] Lager and Koelsh reference DU support
Message-Id: <CANqRtoTyxPiA4v0WAyySVTOUCXF6a23L5p1XSMC_UL1Aamm_5Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392151790-11262-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1392151790-11262-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 12, 2014 at 5:49 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Hello,
>
> These two patches add support for the Display Unit to the Lager and Koelsch
> reference board files. The device should ideally be instantiated through DT,
> but given the lack of DT bindings for the foreseeable future platform devices
> are used as a temporary solution.

Thanks for this. I think the code looks clean and good.

> The patches are based on top of the "[PATCH v4 0/2] [RESEND] Lager and Koelsch
> reference serial port support" series that I've posted earlier today.

Ok, thanks for also developing the serial port number conversion
series. I'd like to separate this relatively simple patch series from
the other series due to the complexity and potential breakage for the
serial port conversion. So please prioritize this series and submit it
independently.

> Laurent Pinchart (2):
>   ARM: shmobile: lager-reference: Add DU device
>   ARM: shmobile: koelsch-reference: Add DU device

Given that the patch series are shuffled around:

Acked-by: Magnus Damm <damm@opensource.se>

Thanks,

/ magnus
