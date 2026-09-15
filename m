Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9485476CDE
	for <linux-sh@vger.kernel.org>; Tue, 15 Sep 2026 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789510894; cv=pass; b=cD1v+oYd7gBwOYaSpNzHaStAWJxn7jLRakQkzkOy2rQ+dUs2n/2g3S+27rGRedlUu/9YlGUR6TxyJ8RvxTty2NL7lOx/gnjf8ZOAQlwp4k0he9miCan653rQsdePJt0Lh3CHjskpCkFhNQ7Cxzv/jG4rUfLJsWStXfV9oXiCNWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789510894; c=relaxed/simple;
	bh=zMEH3dKvgIFeOLNgenpgNKtSSPQyo3I2Bi4hOFPx7Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRjEY6GhYqeNtkIuoHAh48h39NdOEHEWD5TdcUWEB6SQs6iGQnyKRjJCkX2jC8ey/BZ2DUVNZdPfq+KfSHDyWbxcncMsv2XSZn+xs2IMlKdEOlZqJM+GuHbrjdt0QfvJmNDRisrzhm0bDexRKKyiEGE6rLJ1tYiJQtUfNk9YGso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IV/k2TQj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aB07AtjI; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IV/k2TQj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aB07AtjI"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLZ7f0980276
	for <linux-sh@vger.kernel.org>; Tue, 15 Sep 2026 22:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=; b=IV
	/k2TQjkUrsTGpshqW8f1AkLpzgE6WqJLnJXyVNHKYz8mozA+vLQbIOpShvI99Nvk
	BGk11nj45xZQZMebNdo7NiYw/EO7W5wcvHVc8eAkRKtGrNMclkKkbe3unomYvdUd
	vFaT1byqggr1zubtRjDzuTG9pECEQdOzFAiv4kdIU3d7CXM0IsQ27dhrP8NvQBkU
	TlOdMgPnM8h4FF25SXM2n03VFD94RLvjnLlaGSHHxie20ptztZeSDX3B4EelrzMT
	n1DLEJiB1mKEp0dVH3Si7JCiMZpC8ZcIigaByfbQDV2F2ANWVcL1rru5kNRyAlZ9
	ag1DWjYpUlLQQuGalXdA==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3xtunvg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-sh@vger.kernel.org>; Tue, 15 Sep 2026 22:21:31 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-46524220c5aso5637307fac.0
        for <linux-sh@vger.kernel.org>; Tue, 15 Sep 2026 15:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789510891; cv=none;
        d=google.com; s=arc-20260327;
        b=iodGM567VSy2zMRgdROSrOuVvFJ3jqLoVw1TawDffGPMnEXkMunUuZXd7DogXj20oV
         /14N5AGLqxvyyfmQG+cYJVHieX5wLB3B1E1fBc8/CHe7Wkgp98VwAUY2W6T/mt30F5tH
         NHWnCQZvoz0dCl+gh3Bsa2tMLD+vTrb/hega/5sScnofbcbyaTKZx3PBi1doEcr1e/IJ
         yeDx8vQo3QxpkaW4LghvrljBYEym9H74t/QYPgaHYXdVB/abkHKXE2so0Lfou3IeIb5Y
         ynhMrBrROzmg5aACGIWPxhJryv+2HcYHZXOpn8Ffi0KSR2xtS7hAQhYhJ19ARb6IueK7
         v27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        fh=Ij9f0ZfK10I72KWEOv/+l5Vf9UKeOcet5DzKWQvsQbs=;
        b=ECMQAEFi1TZsinSkYYn3AEMwr9/XUjnT6NIHl/kH5Kdbh92EAjbW7eJrqJLpgp6yWm
         ssAd5KdXG9aTJ4kUbtEsg+QfPWH2TlB1XXfEyy8d3KT3hVMkEijzwxY5czA+O96E1+Od
         e1JEO7p8236L3De68YWZDQo5U3+ggD2zz433wcN7ZPpxusq1S5NIX5tNipw5qeJv+Qq5
         XoL8GKNklGNNfajo/6ryHdFbC8RJ5aHmCRzRI4b2krdcBn242q/ieZbVD1NjpOK62WlJ
         Qw9c15pWPiz+ZNsH11aa9ctkR+2yisaLVxXE5umO+LsVihLUm+adiStkrXoMsbo2ZfNV
         VHCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789510891; x=1790115691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=aB07AtjIKjPYRGcvBSuVUhbZlxd1+55zy/NhIuvnz19m7qssQTpE/4jhghs82a98Dx
         rtzGuCLITyYJpv6qqsfwRyWf2V/rvp/BavfnHKk+3jeYdHSZJCYDfk5x4efzm884vIfW
         UjGKSA8ySqC+bc1butY/HkkuCwEw+HH62Uipjk8j8bjqvTXRubAdUvP+c5BJvALTKQeE
         2MFV1Wjr7h5QJcQaotkuVTv077nzlClUSJUJjEEq6X2ukv02bdE+qejZx/+uCM7gRcPt
         xEQKVpHKyQ6abdYF/Q1vdcAj2ZFa315JGdv0g44dh8zUZEwY87qYbRStthdyfxwDukm3
         Mbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789510891; x=1790115691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=ojaBJwA79lt4lBxep6TSSJRuzXHADKIv3WiZg42ts5P98HXN4a7tFB9NllIU4jjz+B
         cy/hW1BhghYlGMj3GDFskHR9wyEPKgZMzAUuC3u82dN3z50LLxL+JgJYjJgEid388e1x
         7r1ZpfdSZa8duXwUxQ3hM+KeDqRMhYFAdHXrtHIg7IkCTUN9K/9muf16Y7O0Se9/gs2g
         nGxquMpwaTxGGlHM0Do+ztKtoiauoG/fID+Na1JkxWwnO7F8LZ3xC9+D4iGuMGJUjpfn
         u9YFMnMNGIbcK0FcGjhqj47fv93oBJJX+5DIL01sB/QJQFKmXhGCvDop8DG3LOKrIgzl
         yq0w==
X-Forwarded-Encrypted: i=1; AKwUvBwygtG+KJUgmyU62ew6xRBV7Xyt3PPNBxYbc0L4poHMbU9o4/I7KDnw1jTGW2e6xPgesefrSXuOLg==@vger.kernel.org
X-Gm-Message-State: AFuF++lprda+d9xzSqhJAo0gvmUIe6o7uJEIUHn3hFN/Thl/UMhGNOX3
	bm4SDGl/P3J6iF7B8Ntov87kkXbQmFO6QL2BZ1GE+CkC3Cp1SZGJY9KLe/WUqofOWhmMD5DZIL/
	ueVaNnR6GutQpQSoKX2O49spHPqiT+nnTHZnbS7VZ6ESMaeUi0bRWqTaKreDX7meMJdWdaKLC+3
	+goNbYcWeLYPhEa1b1slPmuP2HjVe5RCAaTqEPxxSFxzqt
X-Gm-Gg: AYBFou22ZvV7eROEEIcaWQEXfMTnRyv+eohY06nKRiXN+4ze8UiT7HZQ2X7ELtTud/i
	fLta+CH5U68QbskMabyGn+zOXwct6a++27K6zJUFy336FpmnCWoFCMSr7XldvI5JIDLlW233liQ
	ucORt8adtU4EfPB6mb4IUpBmawVcVlSPvlfbeNuPfoYmxBl8j3zIims9dX
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id 586e51a60fabf-4847584c51dmr189770fac.2.1789510890862;
        Tue, 15 Sep 2026 15:21:30 -0700 (PDT)
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id
 586e51a60fabf-4847584c51dmr189724fac.2.1789510890430; Tue, 15 Sep 2026
 15:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
In-Reply-To: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 15:21:18 -0700
X-Gm-Features: AcwNN1UxxSxAxz0XPK7niSod0Tx_HsUs-C3mKdcqDSaFkh659BGkCorPygYZGHE
Message-ID: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, bpf@vger.kernel.org,
        David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev,
        kvm@vger.kernel.org, kexec@lists.infradead.org,
        linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: GzRPXSCZG62bBDWNc-XdjmS-tE0NWE69
X-Proofpoint-GUID: GzRPXSCZG62bBDWNc-XdjmS-tE0NWE69
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfXxKxKVL1F9rMv
 bNzXFZeLBPnpimRJ2Z72XN5q8xTCbAvBKQhDCyMy7VQ40uHUa6XM+fZwk8rk1hZK/E5ja1r20MV
 ZWLAbHeXCOr83zybIh6ATBO+o8RjrJE=
X-Authority-Analysis: v=2.4 cv=As97T+9P c=1 sm=1 tr=0 ts=6aa9c4eb cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
 a=2Rxv5svHm-zNKBYa0PsA:9 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfX7mrBTvcIaqJ+
 3D4MG5woy+gsGb+u6TYRBSGGP122kdkfUcMMUs8u4U0lkCD1LVyEYxUSkiwOEJXQPtV5wQJ2Xvp
 fUibIZSv77Zr5auVHZepdhpfuOSayZyIHetW42UxSgRJpQ9EG32+Zfc4KucFKmhQ4hZagX5+MOa
 AsarYXqyfOrTU07Tr3sVeTiAzgt6z3aes24rL1metnxLITUJSn9XPGkuWx3jRLJ5gTXG/2mSgUr
 g2WKaRl+s0wylYqmLWMWjB1qMRO03G6noZFvDdayRmy8Tz0kcbiTRMBcV/os/XXpX8jNZlpluY6
 qxsZYDBGUjPJt+NOGpvw8YSQmMvB4UzGRzv7ZIwuvfypAxpQ4aPLQx+0MZJ48C2PDjEYbFOw/U6
 t63PVx6SzXWN7tDazya+uUjtsUVX40ohzToWLnAlVwDQyYbIncEQEMzisz8UaqHxEpB+AOvjr2F
 EH6ZQ6P0fe+Uq5NM6dQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150326

On Tue, Sep 15, 2026 at 9:02=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wro=
te:
> >
> > TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> > allocates a descriptor like get_unused_fd_flags() does and records it i=
n
> > a slot on the task. fd_stage() attaches the file to that slot and
> > returns the number.
>
> Honestly, I am *not* a fan. At all.
>
> I think this adds complexity rather than removing it.
>
> The diffstat tells a story:
>
> >  106 files changed, 962 insertions(+), 861 deletions(-)
>
> in how this adds a hundred lines more than it deletes.
>
> But to make things worse, it adds them in bad places: low-level
> architecture assembly code.
>
> Those extra lines are *not* making complicated code simpler. Quite the
> reverse. They are taking fairly straightforward "just deal with errors
> with normal cleanup in the place where it makes sense" and makes the
> *straightforward* case simpler, while making the big picture more
> complicated and subtle, and adding new code to places that are not
> simple and just blindly do somethign that makes no sense in that
> context.

With fd's it is more than just about error rollback.. exposing an fd
to userspace mid-way thru an ioctl is an easy security bug to write..

OTOH, "just use FD_PREPARE() / fd_publish()"..

BR,
-R
