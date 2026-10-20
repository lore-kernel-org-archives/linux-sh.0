Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792514337;
	b=J7igegboecUbXguMT8Inn4OH8NOBA1LBmtVaEke5qiyOQ5HIaE16IV/a08hbFfQ3OBJZ
	 cc1pl9nt8JiUWrltmPcw6TMn6vvqNEFwg4lt0H0kY6TTpyyMJ1hv0MSLIbdyNQwvw0jHY
	 DtPA5fRfSoqLRZuxJmGIhkZcx/T8aotJSEK8YTR9TB00+WZKtQItTycFElRDZLesrhVGF
	 vp57O8dXSWWkL/ovpb8MFFNSJn3c8uZkl19rXdgpjvtlP2SjG1DThnaYvFh1LNCv1FulJ
	 oBMINrENnjQ2bZsN3XPW1njmtNhcgq56ywg5vgTnpjUfV39fCVHpbSNQ40XMGnnSuVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
	b=2fSrVRxIz/g6g61vb1YIuAqa0P19Z8NZ5mLJHLfDcFC2RnHDQDqqO6hVQXjaeWfyvRum
	 gNGr+Pla51Os5t9kXfsvtCe5jRQLF78aPltRi+4aRSDlA1oz5FU10XnctzEUAb4JwVR3+
	 0TpSfOhO36KhjgXH4EnuhCgS6wCaAioLagNvED4x9VSJYBvRy+K5Bckzsh0y6bt2tXzN8
	 pcOyVUPXyCeeopZiXpvE47s7dRSVnbn9My8HDeUHI25qPlOZ3hPynebuC00wIlJp5ihVt
	 FB9rISaXmtYj6xXz2oXMXbYwC7BvGj5iqPb2MJAMlXSYV9oPRfsu77B8n9f0OzUvEAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F2D60A2639
	for <linux-sh@vger.kernel.org>; Tue, 20 Oct 2026 16:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05F2D60A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8ad5b31c7so19815905ad.3
        for <linux-sh@vger.kernel.org>; Tue, 20 Oct 2026 09:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792514336; cv=none;
        d=google.com; s=arc-20260327;
        b=VPH/gvni+1Rk5qa4eR1tF0vQ/WcM+1W5UyHouItwo9zo5XT5plNHpx8jrdNd8qX0QB
         afdcbsG/7DuEYnfqmqpHMRoWMf2oKtjBmFi03Q3HuUOlkHx1eUooj+FU8UEIPTj1iOfR
         AMBduzn+P/bDm03789hwOB2sMtuRwS715SNdMXHcLye9VuK6AP62LoQzVnwvRARiGLAx
         JSGAc0E+78+kgrpK0vc2UERxOJFfXo3nHR5u7pGH95JYmrIWhEfQDu8CeAnOGNcUv3p+
         difWRuONsvg00n5Sqrh7ADGIALGCTkpL53w5KFrHuMD0k2ASp9bKsyuUdEDdtwuru1Bi
         kJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        fh=JSTNS1kNcxaScJ3cl0MPe20Bz/ecXWXp9vruEvcRRKs=;
        b=paV2iAyxMrVePeu+lJx5tGYnW89scMD1j1IKGGM83j1LudanXWLAZkry8u/3IPjtjp
         3W2a7seHF4faCnE3REPBvVp/cc6FudgW35EymI6qT3w/f1jxmaM8kdaHlhRyl3O2FyBt
         f5dw8Hvy1WY9YwYAuM7ub69I4bZdDnj/WMkrBC4wiQCptwULWiGd2IcQtVSyAQ9SUBCl
         AYZjfH1yFg7DWmS6XWgZrFFvKeTs6qzQpxRpDwm3vVZX9M4q2ywdt1gn1Xp0ZNXjNnqd
         X05DdefAhVwo9RZF5QaY+qhwiEmPGlWGmxhHcegRJ9m2/1f2IbMPg1bN6YX/Ys3fEwU6
         QiYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792514336; x=1793119136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        b=GwYGVURAL7E3Gqp1mE6IbppA5fK/M6QVj3T4+Mu1VqNJAQWSHTCgIBs7lXAHx7VP4b
         X7Ol6JtjEVwHUVW/UUWijctAKk0S3FIF6sAkL2D0z4+yun1CiPIG05jQakKiuYArY+di
         qKUZ2JssWHS9PY4Rrbam2j+K8HSVipMYAjJhVwlz0qlw5vC30c9m2oPlM5nOac4bwKsb
         0iIOeo41vgbotndmbkqO3IW2nEL8EcaGXBwYuALkuaiWKHExqpmpd78k/kVF659++rVb
         16kcHMvBo17gh+L06xflahlYQXJ+NMSTGDwKIeHcy9Z1IKqewLhKEpxT50Ywi1EBHbtT
         Ya6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514336; x=1793119136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        b=j9MYZCc8r277hf9MVbFtx2BN4tHV5BxPdxSHqnkBLyM6Nl4rvQ4ZLYYacb8W+KOooj
         B+ZuTZLD1O5pU/Mq0deeWbmtyNBXkTUa/jjJTLIJy1PHWy7A2UYtp0SBom8IbUUjgC38
         hpiQcdPZNR3lySO3pwCQinOr92uzwRWOS5FBnl3UJyBpqvxZDQsOOs/UMKvBvpcCXpLZ
         W1vksbPtBVcS0mAxjXzJyAXw88neEzPFMS/JZw9wx2+usaxF2Gl3Y6eW+M0L2ONCna2w
         5urVh88aZYVLxIGA4H+Ls5g8lfdV0PcIm/sEZSykOoK8zhkuv6pnSlxHE2ziPxVvHqNT
         bwFA==
X-Forwarded-Encrypted: i=1; AKwUvByGw39WzFyjyVzZDPfLRrOzRaU5sQNWJ+aqgVUPkv17p8/7F9te1MYILv3keMgwgnx3Vg51eIxL9w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIGbTOUxhSGpI1fxg8RdBeay5Ndx+4K61GEOT129VPW45zqdyD3
	uejxxf/+DkXJESaohjA9z6aRJ7hvgPLauCLUpEVbOushRNKyjQPi0WBtjxGOxcPLruc+0LzXB9G
	b0q5o72MWKpCICggucRNhTcWj1JokZNNwe9YkEynS
X-Gm-Gg: AYBFou3dMbKIvB5U4laxoXPgmqkM91DH74WTD3ZI6jp26H2cN2cc9M2Dn1uH5+/MwNB
	39LnCsW0q8Jo4Mt25DheqUvHyRuD0/5PXhRS+vTRffBCB+khw0lReGNl5hkh1qoUSrS5d7p49Ch
	BON61fLziioob3Tq6cpdZQHpGS6t2QpaTyZuxExLkuKimU+Ml+aQIFtL3rsAKs4pWsYZovpvCLb
	MWDbr1PMQsyLpP2DtIQidY2VoRRDciEiBTdHPzziXC5K04SVSrTMdiSnrSVeqLNwc/gJkvBGpMb
	AMlLzNCgFmni9gpjzM9Nz31Vo8ZZ6YBmFhKnJL//J9ATm3IhSnHeANwxJDANuJoZSwh3t708ec0
	6OeMSz/mEZ9s=
X-Received: by 2002:a17:903:1111:b0:2e6:dcce:8227 with SMTP id
 d9443c01a7336-2e9a6c1a30dmr99034965ad.37.1792514336247; Tue, 20 Oct 2026
 09:38:56 -0700 (PDT)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
In-Reply-To: <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Oct 2026 12:38:41 -0400
X-Gm-Features: AclHuK9ZakV6IFm9eD67kaqUic0iU1MgVPLS7VN6RgjPgTRZmZP6_X_XOYOX9ZU
Message-ID: <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@redha=
t.com> wrote:

...

> > * As pointed out by Sashiko, when you were converting all of the
> > arches, it looks like you missed alpha.  I took a quick look and it
> > appears that it should be a pretty straightforward conversion like
> > most of the others.
>
> I've actually dropped the alpha patch as per Magnus's request [1].
>
> [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4=
BLWOvDTt92t5Eg@mail.gmail.com/

The problem is that as things stand, this patchset breaks the build on
Alpha.  Perhaps this gets resolved during the current merge window,
but as you know we can't break the kernel build ...

https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.com

--=20
paul-moore.com
