From: takasi-y@ops.dti.ne.jp
Date: Wed, 25 Mar 2009 14:46:58 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <200903251446.n2PEkwgO001691@smtp09.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

> Yoshii-san, any comments?
I still prefer to write them in _real_ assember (without having any good idea), though.

> > > But do we (you!) really need to jump forward?
> >  Not really but I'd like to have no constraint if possible
> Then I vote for adding it later when there is a direct need. You can
> implement delay using backward jump only, right?

Because this is a kind of assembler, we can use its technique, like
making pointer link of undefined labels on its reference,
 and resolve them following the link when the label is defined.
Then the code will be

 /* forward ref. This make link because label is not resolved */
 sh_pm_op(info, SH_PM_OP_BT, sh_pm_ref(info, &label));
 /* define label, and resolve above using linked list */
 sh_pm_label(info, &label); /* define label, and resolve above */
 /* backward ref. This simply use label value */
 sh_pm_op(info, SH_PM_OP_BT, sh_pm_ref(info, &label));

But, I don't think we need even backward jump.
What we want is conditional wait and delay, isn't it?

SH_PM_OP_WAIT_UNTIL_EQ(addr, value) while(read(addr)!=value)/*wait*/;
SH_PM_OP_WAIT_UNTIL_SET(addr, mask) while(!(read(addr)&mask))/*wait*/;
SH_PM_OP_WAIT_UNTIL_CLR(addr, mask) while(read(addr)&mask)/*wait*/;
SH_PM_OP_DELAY_LOOP(count) while(count--)/*wait*/;

/yoshii
