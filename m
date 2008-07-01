From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Tue, 01 Jul 2008 11:22:56 +0000
Subject: Re: [PATCH] Touch screen driver for the SuperH MigoR board
Message-Id: <aec7e5c30807010422m4ea7dcdqae2efe5caf93efb2@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <486A07E7.1070906@mpc-data.co.uk>
In-Reply-To: <486A07E7.1070906@mpc-data.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Nicholas Beck <nbeck@mpc-data.co.uk>
Cc: linux-sh@vger.kernel.org, linux-input@vger.kernel.org

Hi Nicholas,

Thanks for your email!

On Tue, Jul 1, 2008 at 7:33 PM, Nicholas Beck <nbeck@mpc-data.co.uk> wrote:
> Hi Magnus,
>
> Firstly, thanks for the great work. I have one issue with the touch
> screen driver for the MigoR board though.
>
> I don't get any BTN_TOUCH release events using the touch screen driver
> for the MigoR board. Do you experience the same problem?

This problem has been fixed by Dmitry Torokhov. The linux-input
archives seem gone though.

The updated patch below did not make it into 2.6.26, but it should be
included in 2.6.27.

http://git.kernel.org/?p=3Dlinux/kernel/git/dtor/input.git;a=3Dcommit;h=885=
c316d776b64728b4ed30e3af60d23c9e46825

> I have a patch that adds a timer to perform the BTN_TOUCH release event
> (kind of like a WDT), that I can submit if this is of any interest?

Does Dmitrys patch above solve your problem? If not, please post your
patch and I'll have a look.

Thank you!

/ magnus
