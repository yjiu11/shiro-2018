package com.yjiu.shiro.pojo;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
@JsonInclude(JsonInclude.Include.NON_NULL)
public class SysResource{
    private Long id;
    @JsonProperty(value="text")
    private String name;

    private String type;
    //@JsonProperty(value="href")
    private String url;
    
    private Long parentId;

    private String permission;

    private int available;
    //@JsonProperty(value="nodes")
    List<SysResource> children;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public String getPermission() {
        return permission;
    }

    public void setPermission(String permission) {
        this.permission = permission == null ? null : permission.trim();
    }

    public int getAvailable() {
        return available;
    }

    public void setAvailable(int available) {
        this.available = available;
    }
	public List<SysResource> getChildren() {
		return children;
	}

	public void setChildren(List<SysResource> children) {
		this.children = children;
	}

	@Override
	public String toString() {
		return "SysResource [id=" + id + ", name=" + name + ", type=" + type
				+ ", url=" + url + ", parentId=" + parentId + ", permission="
				+ permission + ", available=" + available + ", children="
				+ children + "]";
	}
}