From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 May 2009 10:51:54 +0000
Subject: Re: [PATCH] sh: clkfw: Moved the .init callback in the clk_register
Message-Id: <aec7e5c30905130351p22e72f3as8887177f013669eb@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1242050283-7986-1-git-send-email-francesco.virlinzi@st.com>
In-Reply-To: <1242050283-7986-1-git-send-email-francesco.virlinzi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Francesco,

On Wed, May 13, 2009 at 3:08 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
> This patch moves the .init callback in the clk_register function.
> Moreover not the .init callback return a value:
> =A0- zero means the initialization is ok and the clock can be registered.
> =A0- any value not zero means there is a problem in the initialization and
> =A0 the clkfw rejects the clock registration
>
> Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>

Thanks for submitting patches and doing so inline. =3D) Very good! I
have no major objections to this patch, but I'm not sure how well it
will apply to the future tree. I think Paul is doing some
restructuring of the clock framework in a separate branch so you may
want to have a look at that (in sh-2.6.git).

Cheers,

/ magnus
