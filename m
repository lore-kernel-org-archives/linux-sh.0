From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 09 Mar 2009 10:57:43 +0000
Subject: Re: [PATCH] sh: hibernation support
Message-Id: <aec7e5c30903090357l799b7affsd9d25c6aae3fd6d0@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Mon, Mar 9, 2009 at 7:03 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
> I'm sorry if I'm stressing you but you will have similar problem also with
> the clock framework.
> A simple
> - =A0clk_get_rate(...)
> could return a wrong value if in the previous session someone changed the
> clock rate (from init value) and
> you don't force again in the hw the resumed "clk->rate".

Yeah, the clock framework needs more work. =3D)

/ magnus
