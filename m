From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Tue, 07 Dec 2010 13:43:47 +0000
Subject: Re: [PATCH (sh-2.6) 1/2] sh: add stack smashing protection support
Message-Id: <20101207134347.GI21020@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1291717254-17455-1-git-send-email-filippo.arcidiacono@st.com>
In-Reply-To: <1291717254-17455-1-git-send-email-filippo.arcidiacono@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, Dec 07, 2010 at 11:20:53AM +0100, Filippo ARCIDIACONO wrote:
> Add stack smashing suppurt for SH architecture. This is based on work
s/suppurt/support/

> from Nicolas Pitre for ARM (c743f38013aeff58ef6252601e397b5ba281c633).
> Use the ARM boot_init_stack_canary function to initialize the guard
> canary. It has been placed under asm-generic to allow archtectures
s/archtectures/architectures/

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
