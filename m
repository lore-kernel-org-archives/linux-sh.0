From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 09 Dec 2009 12:00:34 +0000
Subject: Re: [PATCH] sh: Add CONFIG_PARAM_* to set boot parameters.
Message-Id: <aec7e5c30912090400q1441d81dv3817059d1f73e0f6@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
In-Reply-To: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Tue, Dec 8, 2009 at 10:14 PM, Stuart MENEFY <stuart.menefy@st.com> wrote:
> Folks
>
> Paul Mundt wrote:
>> On Tue, Dec 08, 2009 at 02:01:26PM +0900, yoshii.takashi@renesas.com wro=
te:
>> =A0zImage doesn't provide the way to know the location.
>> =A0Check your kernel configuration file to know where it is.
>
> This is the bit which is nasty. Because we don't use the parameters which
> are part of the zImage header (head.S) which are still set up for x86,
> the boot loader has to know where empty zero page will end up.

I agree that it's nasty, but it is possible to figure out the location
of the zero page from the zImage binary. The kexec zImage loader code
does just that, and it should work regardless of the page size
configuration.

/ magnus
