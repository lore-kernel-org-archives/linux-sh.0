Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDEB374190;
	Wed, 14 Oct 2026 02:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946156; cv=none; b=QwKAoV8gnrkOE/1lUGBHTRYmuCJe4W86I1bVuBpmvYWCJQDsDsOqmmHobZIwFE+JFp1IkP7hdqtQY8rKa0d18pJlb4ftCduORF3Dl4VN7y8SmpBKr6SgfUBskiJrKKmumTJ7HbSKshc8pKs2Stm6aM2W4KNpE7eKMTLc2/HK71w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946156; c=relaxed/simple;
	bh=FPVtKNFKhs74PqTgnsdli633r0wWfPveVqPiAJd1qh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rgwwxv2F06FWZQIWjUgAUWjP8sjOrYyZoRp0EHUmFo9BRYle1tetR41kfdPBitfLdHq234dAtibZ7x2ei507rALjwj3TrSFrWDVZByS/8J4ot0LjX4q6/zE5ylCMbAge6sqop1+FEgH9TpIIeZvlm7mXw06+jO4u7xKlMMF5W18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=heomhiLq; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="heomhiLq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=FP
	VtKNFKhs74PqTgnsdli633r0wWfPveVqPiAJd1qh4=; b=heomhiLqq1o/PGrMGf
	R87EqtgVgKU0TnZTg3QRQTVpxmDokOow2YJIq6mKC2kNbHQZsKaCGjc4h/UvO8Rd
	b1uQZ/aA4s2qWt/QhiISv5GpN3J87R2k7y4YbXZZMxP9vbMh9wSe3KBF5cV1so7x
	a9JDpQQxsTA2NuWEJl8EoeS1M=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3_8Jq7c5qLnY1Eg--.43334S2;
	Wed, 14 Oct 2026 10:48:11 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: glaubitz@physik.fu-berlin.de
Cc: kmehltretter@gmail.com,
	geert@linux-m68k.org,
	ysato@users.sourceforge.jp,
	dalias@libc.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hppiscas@163.com
Subject: Re: [PATCH] sh: Use generic OHCI platform provider symbol
Date: Wed, 14 Oct 2026 10:48:08 +0800
Message-ID: <20261014024808.78150-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2ccce813ce4d615af2ca880da19501deaa562c22.camel@physik.fu-berlin.de>
References: <20260624081926.12426-1-pengpeng@iscas.ac.cn> <CAMuHMdVkL629ps2mmD3XRXM-BYWXZ-6GQGM7tKf6vEvhK--LBg@mail.gmail.com> <20260920031112.98903-1-hppiscas@163.com> <2ccce813ce4d615af2ca880da19501deaa562c22.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_8Jq7c5qLnY1Eg--.43334S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfU5LvtUUUUU
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7QzkrWrO7WyQeAAA3l

Hi Adrian,

Please use Karl's v2:
https://lore.kernel.org/all/20260905145225.88518-1-kmehltretter@gmail.com/

It carries the same symbol replacements, rebased, with the requested
Fixes tag and Geert's Reviewed-by. I have no additional changes to make
and will not send a competing revision.

Thanks to Karl for picking it up, and to you for collecting it.

Regards,
Pengpeng

