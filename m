From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 11 May 2009 08:36:27 +0000
Subject: Re: [PATCH] sh: clock framework update, fix count and kill off kref
Message-Id: <aec7e5c30905110136p76838d62t8a61452615dda8c8@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090508082329.30220.74580.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090508082329.30220.74580.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Mon, May 11, 2009 at 4:34 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
> The design I have in mind is:
> - the .init callback should be called during the clk_registration and
> =A0if the init fails the clock framework rejects the clock.
> - Any operations with (CLK_NEEDS_INIT) =A0has to be managed internally to
> =A0the clock-SOC implementation via archflag (or a void* private_data) to=
 hive
> any
> =A0implementation issue at clock framework level.
>
> Magnus, Do you want add anything?

Not really, except I have to test it and make sure it will work. =3D)
There may be historical reasons why the code is written as it is, so
let's try to only call init() from clock registration and see how that
goes. Do you have a patch? =3D)

/ magnus
